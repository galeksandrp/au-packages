import-module au
import-module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?is)(^\s*\`$updateData\s*=\s*)('[^']*')"        = "`$1'$($Latest.updateData)'"
        }
    }
}

function global:au_GetLatest {
	$checksumType = 'sha256'
	$hostname = 'https://e-trust.gosuslugi.ru'

	$rootCerts = (curl "$hostname/MainCA").links.href -match '^/Shared/DownloadCert\?thumbprint=' | % {
		$thumbprint = ($_ -split '=')[1]
		$out = @{filename = "$thumbprint.cer"}
		Get-ChocolateyWebFile 'mainca' "$hostname/$_" -FileFullPath "$env:TMP\$($out.filename)" > $null

		$out + @{url = "$hostname$_"; cert = Get-PfxCertificate -FilePath "$env:TMP\$($out.filename)"}
	} | ? {
		$_.cert.Issuer -eq $_.cert.Subject
	}

    $version = ($rootCerts.cert.NotBefore | sort -Descending)[0] | Get-Date -Format 'yyyy.MM.dd'

    $rootCerts = $rootCerts | % {
		$_.remove('cert')
		$_ + @{checksum = Get-RemoteChecksum "$($_.url)" $checksumType; checksumType = $checksumType}
	}

    @{
        URL32           = $rootCerts[0].url
		checksum        = $rootCerts[0].checksum
        updateData      = $rootCerts | ConvertTo-Json
        Version         = $version
    }
}

update

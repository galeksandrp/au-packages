import-module au
import-module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
	$hostname = 'https://e-trust.gosuslugi.ru'

	$rootCert = (curl "$hostname/MainCA").links.href -match '^/Shared/DownloadCert\?thumbprint=' | % {
		$filename = ($_ -split '=')[1]
		Get-ChocolateyWebFile 'mainca' "$hostname/$_" -FileFullPath "$env:TMP\$filename.cer"
		Get-PfxCertificate -FilePath "$env:TMP\$filename.cer"
	} | ? {
		$_.Issuer -eq $_.Subject
	}

    @{
        URL32   = "$hostname/$rootCertUrl"
        Version = $rootCert.NotBefore | Get-Date -Format 'yyyy.MM.dd'
    }
}

update

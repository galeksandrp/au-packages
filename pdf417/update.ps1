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
	$versions = [ordered]@{}

	$baseURL = 'https://www.gnivc.ru'

	"/software/fnspo/software_ul_fl/pdf417/","/software/fnspo/software_ul_fl/pdf_417/158125/" | % {
		(curl "$baseURL/$_").Links.href -match '\.(rar|zip)$'
	} | Get-Unique | % {
		$URL32 = "$baseURL$_"
		$archivePath = "$env:TMP\$($([uri]$URL32).segments[-1])"

		Get-ChocolateyWebFile 'pdf417' $archivePath $URL32

		$versionFolderPath = "$env:TMP\$($(ls $archivePath).BaseName)"

		Get-ChocolateyUnzip $archivePath $versionFolderPath

		$(ls "$versionFolderPath\*.msi").BaseName -match '\(([0-9]+[0-9.]+[0-9]+)\)'

		$versions[$Matches[1]] = @{
			URL32   = $URL32
			Version = $Matches[1]
			File    = $(ls "$versionFolderPath\*.msi") -replace [regex]::escape("$versionFolderPath\"),'$env:TMP\'
		}
	}

	@{'Streams' = $versions}
}

update

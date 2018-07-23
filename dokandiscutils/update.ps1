import-module au
import-module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*FileFullPath\s*=\s*)('.*')"        = "`$1'$($Latest.FileFullPath)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
	$URL32 = 'https://codeplexarchive.blob.core.windows.net/archive/projects/DokanDiscUtils/DokanDiscUtils.zip'
    Get-ChocolateyWebFile 'dokandiscutils' $URL32 -FileFullPath "$env:TMP\DokanDiscUtils.zip" -Options $options
	Get-ChocolateyUnzip -FileFullPath "$env:TMP\DokanDiscUtils.zip" -Destination "$env:TMP"
	$versionObject = (cat "$env:TMP\releases\releaseList.json" | ConvertFrom-Json)[0]
	
	@{
        URL32   = $URL32
        Version = $versionObject.Name -match
    }
}

update -NoCheckUrl

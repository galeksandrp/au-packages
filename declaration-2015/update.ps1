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
	$URL32 = (curl 'https://www.nalog.ru/rn77/program/5961249/').links.href | % {$url = ''} {
        try {
            $filename = ([uri]$_).segments[-1]
            if ($filename -eq 'InsD2015.exe') {
                $url = $_
            }
        }catch{
        }
    } {$url}
    Get-ChocolateyWebFile 'declaration-2015' $URL32 -FileFullPath "$env:TMP\InsD2015.exe"

	@{
        URL32   = $URL32
        Version = "$((ls "$env:TMP\InsD2015.exe").VersionInfo.FileVersionRaw)"
    }
}

update

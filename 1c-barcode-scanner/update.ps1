Add-Type -AssemblyName System.Web

import-module au
import-module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)^\s*(?:install|installArchive)\s*$"                 = "$($Latest.function)"
        }
    }
}

function global:au_BeforeUpdate() {
    #Download $Latest.URL32 / $Latest.URL64 in tools directory and remove any older installers.
    Get-RemoteFiles -Purge -FileNameBase ([System.IO.Path]::GetFileNameWithoutExtension($Latest.filename)) -NoSuffix
}

function global:au_GetLatest {
    $versions = [ordered]@{}

	$webrequest = Invoke-WebRequest -Uri "https://login.1c.ru/login" -SessionVariable websession

	$Form = $webrequest.Forms | ? {$_.Id -match 'loginForm'}

	$Form.Fields["username"]=$env:1C_USERNAME
	$Form.Fields["password"]=$env:1C_PASSWORD

	Invoke-WebRequest "https://login.1c.ru$($Form.Action)" -WebSession $websession -Method POST -Body $Form.Fields

    ((Invoke-WebRequest "https://releases.1c.ru/project/ScanOpos" -WebSession $websession).Links.href | % {[Web.HTTPUtility]::HtmlDecode($_)}) -match '^/version_files\?nick=ScanOpos&ver=' | % {
        $version = [System.Web.HttpUtility]::ParseQueryString(([System.Uri]"https://releases.1c.ru$_").Query)['ver']

        $urlRelease = ((Invoke-WebRequest "https://releases.1c.ru$_" -WebSession $websession).Links.href | % {[Web.HTTPUtility]::HtmlDecode($_)}) -match '.+\.(?:exe|rar)$'

        if ($urlRelease) {
            $filepath = [System.Web.HttpUtility]::ParseQueryString([System.Web.HttpUtility]::UrlDecode(([System.Uri]"https://releases.1c.ru$urlRelease").Query))['path']

            $function = 'install'

            $filetype = ([System.IO.Path]::GetExtension($filepath))[1..99] -join '';

            if ($filetype -eq 'rar') {
                $function = 'installArchive'
            }

            $versions[$version] = @{
                URL32    = ((Invoke-WebRequest "https://releases.1c.ru$urlRelease" -WebSession $websession).Links.href -match '://dl.*\.1c\.ru/')[0]
                Version  = $version
	            Options  = @{'CookieContainer' = $websession.Cookies; Headers = @{'User-Agent' = $websession.UserAgent}}
                FileType = ([System.IO.Path]::GetExtension($filepath))[1..99] -join ''
                filename = [System.IO.Path]::GetFileName($filepath)
                function = $function
            }
        }
    }

    @{Streams = $versions}
}

update -ChecksumFor none

Add-Type -AssemblyName System.Web

import-module au
import-module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*\`$filename\s*=\s*)('.*')"                 = "`$1'$($Latest.filename)'"
        }
    }
}

function global:au_BeforeUpdate() {
    #Download $Latest.URL32 / $Latest.URL64 in tools directory and remove any older installers.
    Get-RemoteFiles -Purge -FileNameBase ([System.IO.Path]::GetFileNameWithoutExtension($Latest.filename)) -NoSuffix
}

function global:au_GetLatest {
	$webrequest = Invoke-WebRequest -Uri "https://login.1c.ru/login" -SessionVariable websession

	$Form = $webrequest.Forms | ? {$_.Id -match 'loginForm'}

	$Form.Fields["username"]=$env:1C_USERNAME
	$Form.Fields["password"]=$env:1C_PASSWORD

	Invoke-WebRequest "https://login.1c.ru$($Form.Action)" -WebSession $websession -Method POST -Body $Form.Fields

	$urlVersion = (((Invoke-WebRequest "https://releases.1c.ru/total" -WebSession $websession).Links.href | % {[Web.HTTPUtility]::HtmlDecode($_)}) -match '^/version_files\?nick=ScanOpos&ver=' | sort -Property @{Expression={[Version]($_ -replace '/version_files\?nick=ScanOpos&ver=','')}}) | select -First 1

	$urlRelease = ((Invoke-WebRequest "https://releases.1c.ru$urlVersion" -WebSession $websession).Links.href | % {[Web.HTTPUtility]::HtmlDecode($_)}) -match '.+\.exe$'

    @{
        URL32    = ((Invoke-WebRequest "https://releases.1c.ru$urlRelease" -WebSession $websession).Links.href -match '/public/file/get/')[0]
        Version  = $urlVersion -replace '/version_files\?nick=ScanOpos&ver=',''
	    Options  = @{'CookieContainer' = $websession.Cookies; Headers = @{'User-Agent' = $websession.UserAgent}}
        FileType = 'exe'
        filename = ([System.Web.HttpUtility]::UrlDecode(((([System.Uri]"https://releases.1c.ru$urlRelease").Query -split '&')[-1] -split '=')[-1]) -split '\\')[-1]
    }
}

update -ChecksumFor none

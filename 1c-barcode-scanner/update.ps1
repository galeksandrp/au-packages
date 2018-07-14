Add-Type -AssemblyName System.Web

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
	$webrequest = Invoke-WebRequest -Uri "https://login.1c.ru/login" -SessionVariable websession

	$Form = $webrequest.Forms | ? {$_.Id -match 'loginForm'}

	$Form.Fields["username"]=$env:1C_USERNAME
	$Form.Fields["password"]=$env:1C_PASSWORD

	Invoke-WebRequest "https://login.1c.ru$($Form.Action)" -WebSession $websession -Method POST -Body $Form.Fields

	$urlVersion = (((Invoke-WebRequest "https://releases.1c.ru/total" -WebSession $websession).Links.href | % {[Web.HTTPUtility]::HtmlDecode($_)}) -match '^/version_files\?nick=Platform83&ver=' | sort -Property @{Expression={[Version]($_ -replace '/version_files\?nick=Platform83&ver=','')}})[0]

	$urlRelease = ((Invoke-WebRequest "https://releases.1c.ru$urlVersion" -WebSession $websession).Links.href | % {[Web.HTTPUtility]::HtmlDecode($_)}) -match '\windows_.+.rar$'

	@{
        URL32   = ((Invoke-WebRequest "https://releases.1c.ru$urlRelease" -WebSession $websession).Links.href -match '/public/file/get/')[0]
        Version = $urlVersion -replace '/version_files\?nick=Platform83&ver=',''
		Options = @{'CookieContainer' = $websession.Cookies}
    }
}

update

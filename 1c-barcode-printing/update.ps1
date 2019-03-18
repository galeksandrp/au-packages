Add-Type -AssemblyName System.Web

import-module au

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function htmlDecode {
    param($endpoint)

    $input | % {
        $decodedURL = $_.trim()
        $decodedURL = [Web.HTTPUtility]::HtmlDecode($decodedURL)
        if (!([uri]$decodedURL).scheme) {
            $decodedURL = "$endpoint$decodedURL"
        }
        $decodedURL
    }
}

function global:au_GetLatest {
    $webrequest = Invoke-WebRequest -Uri "https://login.1c.ru/login" -SessionVariable websession

    $Form = $webrequest.Forms | ? {$_.Id -eq 'loginForm'}

    $Form.Fields["username"]=$env:1C_USERNAME
    $Form.Fields["password"]=$env:1C_PASSWORD

    Invoke-WebRequest "https://login.1c.ru$($Form.Action)" -WebSession $websession -Method POST -Body $Form.Fields

    $endpoint = 'https://releases.1c.ru'

    $urlVersion = (Invoke-WebRequest "$endpoint/project/ScanOpos" -WebSession $websession).Links.href | htmlDecode $endpoint | ? {
        [System.Web.HttpUtility]::ParseQueryString(([uri]"$_").Query)['nick'] -eq 'ScanOpos'
    } | sort -Property @{Expression={[Version]([System.Web.HttpUtility]::ParseQueryString(([uri]"$_").Query)['ver'])};Descending=$true} | select -First 1

    $urlRelease = (Invoke-WebRequest "$urlVersion" -WebSession $websession).Links.href | htmlDecode $endpoint | ? {
        [System.IO.Path]::GetExtension([System.Web.HttpUtility]::ParseQueryString(([uri]"$_").Query)['path']) -eq '.exe'
    }

    $url = (Invoke-WebRequest "$urlRelease" -WebSession $websession).Links.href | htmlDecode $endpoint | ? {
        ([uri]"$_").Host -match '^dl.+\.1c\.ru$'
    } | select -First 1

    @{
        URL32    = "$url"
        Version  = [System.Web.HttpUtility]::ParseQueryString(([uri]"$urlVersion").Query)['ver']
	    Options  = @{'CookieContainer' = $websession.Cookies; Headers = @{'User-Agent' = $websession.UserAgent}}
    }
}

update

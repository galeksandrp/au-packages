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
    Get-RemoteFiles -Purge
}

function global:au_GetLatest {
	$webrequest = Invoke-WebRequest -Uri "https://sberbank.business.ru/login" -SessionVariable websession

    $csrfToken = ($webrequest.InputFields | ? {$_.type -eq 'hidden'}).value

    $form = @{login = $env:BUSINESS_RU_ONLINE_CHECK_NAME; password = $env:BUSINESS_RU_ONLINE_CHECK_PASSWORD; _token = $csrfToken}

    Invoke-WebRequest "https://sberbank.business.ru/login" -WebSession $websession -Method POST -Body $form

    $url = (Invoke-WebRequest 'https://sberbank.business.ru/api-web/v1/users/me' -WebSession $websession | ConvertFrom-Json).install_url

    Get-ChocolateyWebFile 'business-ru-online-check' $url -FileFullPath "$env:TMP\sbrf-onlinekassa.exe"

    @{
        URL32    = $url
        Version = (Get-Item "$env:TMP\sbrf-onlinekassa.exe").VersionInfo.ProductVersion.trim()
    }
}

update -ChecksumFor none

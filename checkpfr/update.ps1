import-module au
import-module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*FileFullPath\s*=\s*)(`".*`")"        = "`$1`"$($Latest.FileFullPath)`""
            "(?i)(^\s*file\s*=\s*)(`".*`")"                = "`$1`"$($Latest.file)`""
        }
    }
}

function global:au_BeforeUpdate() {
    ConvertTo-Json $Latest.archives > 'tools\checkpfr-setup-urls.json'
}

function global:au_GetLatest {
    $urls = (curl 'http://www.pfrf.ru/branches/bashkortostan/info/~Strahovatelyam/1423').links.href | % {$urls = @()} {
        try {
            $url = $_

            if ($url -match '^/') {
                $url = "http://www.pfrf.ru$_"
            }

            $filename = ([uri]$url).segments[-1]

            if ($filename -match '.+\.rar$') {
                Get-ChocolateyWebFile 'checkpfr' $url -FileFullPath "$env:TMP\$filename" > $null

                $urls += @{
                    url = $url
                    filename = $filename
                    checksum = (Get-FileHash "$env:TMP\$filename" -Algorithm 'sha256').hash
                }
            }
        }catch{
        }
    } {$urls}

    $archive = $urls | ? {$_.filename -match '.+\.part1\.rar$'}

    $packageArgs = @{
      FileFullPath           = "$env:TMP\$($archive.filename)"
      Destination            = "$env:TMP\checkpfr"
    }
    Get-ChocolateyUnzip @packageArgs

    $setup = ls "$env:TMP\checkpfr\*.exe"

    $packageArgs = @{
      packageName            = 'checkpfr'
      FileType               = 'exe'
      file                   = "$setup"
      SilentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    }
    Install-ChocolateyInstallPackage @packageArgs

    (cat "$env:SYSTEMDRIVE\CheckPfr\Version.txt")[0] -match '(?:[0-9][0-9.]+)*[0-9]+'

	@{
        archives           = $urls
        FileFullPath       = "`$env:TMP\$($archive.filename)"
        file               = "`$env:TMP\$($setup.Name)"
        Version            = $Matches[0]
    }
}

update

import-module au
import-module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1

$toolsPath = Resolve-Path tools

$releases = 'https://gitlab.com/gitlab-org/gitlab-runner/raw/master/CHANGELOG.md'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
   }
}

function global:au_BeforeUpdate {
	Get-ChocolateyWebFile 'gitlab-runner' "$env:TMP\gitlab-runner.zip" $Latest.URL32
	Get-ChocolateyUnzip "$env:TMP\gitlab-runner.zip" "$env:TMP" -SpecificFolder "out/binaries"
	mv "$env:TMP\out\binaries\gitlab-runner-windows-386.exe" "$toolsPath\gitlab-runner-windows-386_x32.exe"
	mv "$env:TMP\out\binaries\gitlab-runner-windows-amd64.exe" "$toolsPath\gitlab-runner-windows-amd64_x64.exe"
}
function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version = ($download_page.Content -split "`n") -match '^v([0-9.]+) ' | select -first 1
    $version = ($version.Substring(1) -replace '\(.+').Trim()

    $cversion = $version
    if ($version -match '-.+') { $cversion = ($cversion -replace '-.+') + $Matches[0].Replace('.', '')}
    @{
        Version  = $cversion
        URL32    = "https://gitlab.com/galeksandrp/gitlab-runner/-/jobs/237707114/artifacts/download"
    }
}

update -ChecksumFor none -NoCheckChocoVersion
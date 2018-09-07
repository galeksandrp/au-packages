$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$installDir = Get-RunnerInstallDir
if (!$installDir) {
    $InstallDir = "$toolsPath\gitlab-runner"
}

if (gsv gitlab-runner -ea 0) {
    & $installDir\gitlab-runner.exe stop
    & $installDir\gitlab-runner.exe uninstall
}

gsv gitlab-runner-* | % {
    & $installDir\gitlab-runner.exe stop --service $_.Name
    & $installDir\gitlab-runner.exe uninstall --service $_.Name
}

Write-Warning 'If a gitlab-runner user is created during the installation, it is not removed as a safety measure'
Write-Warning '  to remove it execute: net user gitlab-runner /delete'
Write-Warning 'If Autologon parameter was used when installing, disable autolog manually'

# It might not be safe to just rm -Force -Recursive, let the user do it manually.
if ($installDir) {
    Write-Warning "Gitlab-runner remained installed in $installDir"
    Write-Warning "  to delete it execute: rm '$installDir' -Force -Recurse"
} else {
    Write-Warning "Can't find gitlab-runner installation directory, please remove it manually"
}
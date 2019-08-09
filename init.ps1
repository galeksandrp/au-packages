function AUPackages-Install {
    Get-CimInstance win32_operatingsystem -Property Caption, OSArchitecture, Version | fl Caption, OSArchitecture, Version
    $PSVersionTable
    git --version
    choco --version
    git clone -q https://github.com/majkinetor/au.git $Env:TEMP/au
    . "$Env:TEMP/au/scripts/Install-AU.ps1" $Env:au_version


    "Build info"
    '  {0,-20} {1}' -f 'SCHEDULED BUILD:', ($Env:APPVEYOR_SCHEDULED_BUILD -eq 'true')
    '  {0,-20} {1}' -f 'FORCED BUILD:'   , ($Env:APPVEYOR_FORCED_BUILD    -eq 'true')
    '  {0,-20} {1}' -f 'RE BUILD:'       , ($Env:APPVEYOR_RE_BUILD        -eq 'true')
}

function AUPackages-BuildScript {
    $ErrorActionPreference = 'Continue'

    if ($Env:APPVEYOR_PROJECT_NAME  -like '*test*') { ./test_all.ps1 "random $Env:au_test_groups"; return }

    if ( ($Env:APPVEYOR_SCHEDULED_BUILD -ne 'true') -and ($Env:APPVEYOR_FORCED_BUILD -ne 'true') ) {
        switch -regex ($Env:APPVEYOR_REPO_COMMIT_MESSAGE)
        {
            '\[AU (.+?)\]'   { $forced = $Matches[1] }

            '\[PUSH (.+?)\]' {
                $packages = $Matches[1] -split ' '
                Write-Host "PUSHING PACKAGES: $packages"
                foreach ($package in $packages) {
                    Write-Host ("{0}`n{1}`n" -f ('-'*60), "PACKAGE: $package")
                    $package_dir = ls -recurse | ? { $_.Name -eq "$package.nuspec"} | select -First 1 | % Directory
                    if (!$package_dir) { Write-Warning "Can't find package '$package'"; continue }
                    pushd $package_dir
                        if (Test-Path update.ps1 -ea 0) { ./update.ps1 }
                        choco pack; Push-Package;
                    popd
                }
                return
            }
        }
    }

    ./update_all.ps1 -ForcedPackages $forced
    7z a au_temp.zip $Env:TEMP\chocolatey\au\*
}

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$filename = 'setup1c.exe'

function install {
    $packageArgs = @{
      packageName            = "$env:chocolateyPackageName"
      FileType               = 'exe'
      SilentArgs             = '/s /sp"/s /v"/qn /norestart""'
      File                   = "$toolsDir\$filename"
    }
    Install-ChocolateyInstallPackage @packageArgs
}

function installArchive {
    $packageArgs = @{
      FileFullPath           = "$toolsDir\$filename"
      Destination            = "$env:TMP"
    }
    Get-ChocolateyUnzip @packageArgs

    $packageArgs = @{
      packageName            = "$env:chocolateyPackageName"
      FileType               = 'exe'
      SilentArgs             = '/s /sp"/s /v"/qn /norestart""'
      File                   = "$env:TMP\ScanOPOS.exe"
    }
    Install-ChocolateyInstallPackage @packageArgs
}

install

rm "$toolsDir\$filename"

$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://github.com/10se1ucgo/DisableWinTracking/releases/download/v3.1.3/dwt-3.1.3-cp27-win_x86.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = '1ffbc30251f147582337b4b229893952b9bbdfa1c13b8019571a7c2ab02be834'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

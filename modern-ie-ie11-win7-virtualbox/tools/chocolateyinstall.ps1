$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://az792536.vo.msecnd.net/vms/VMBuild_20180102/VirtualBox/IE11/IE11.Win7.VirtualBox.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = 'fe47f2434cdd15162d3c9861695de19e6e560cc2a49a853e993be8c189422e74'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

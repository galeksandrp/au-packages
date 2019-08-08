$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://az792536.vo.msecnd.net/vms/VMBuild_20180102/HyperV/IE9/IE9.Win7.HyperV.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = '16f2853c0d27585d118ce5fe50599872d60d39c01373c0047a2d4f136a52aea7'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

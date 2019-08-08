$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://az792536.vo.msecnd.net/vms/VMBuild_20180102/HyperV/IE8/IE8.Win7.HyperV.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = 'c6bf6b15e5194580e6623a00080f9cf4b9ce4f992e9935c6fc2adf1cf5f9ca62'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

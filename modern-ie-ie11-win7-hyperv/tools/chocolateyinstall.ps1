$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://az792536.vo.msecnd.net/vms/VMBuild_20180102/HyperV/IE11/IE11.Win7.HyperV.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = 'a279a6fec015fc4c4083c81d4711db352cf87fd77ef7caebff414f80949152f1'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

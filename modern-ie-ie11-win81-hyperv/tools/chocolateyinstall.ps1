$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://az792536.vo.msecnd.net/vms/VMBuild_20180102/HyperV/IE11/IE11.Win81.HyperV.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = 'cf6eebaa7a808d833c1c1c418d2f72604e27afa1eee9669498aa9a1fd37bbbe7'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

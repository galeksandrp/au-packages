$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://az792536.vo.msecnd.net/vms/VMBuild_20180102/HyperV/IE10/IE10.Win7.HyperV.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = '51d46562285708499a5006851f734ab210667b549e6d19350eeadff9096731eb'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

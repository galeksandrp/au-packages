$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://az792536.vo.msecnd.net/vms/VMBuild_20190311/HyperV/MSEdge/MSEdge.Win10.HyperV.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = '20b8c29df80e1da989d6650dc1e583be0a4fcdfcf365a6fbe11bf04cf8f8dbc7'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

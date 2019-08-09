$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://az792536.vo.msecnd.net/vms/VMBuild_20150916/VirtualBox/IE10/IE10.Win7.VirtualBox.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = 'ff8b51114d13c31742f39fc49a20b035bd5e25e9a35fd29cf41b73aa8fadbd3b'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.13.29/prey-windows-1.13.29-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.13.29/prey-windows-1.13.29-x64.msi'
  checksum               = '0d98b610e245f69a7f825ac5613e133b400ba4d3601ec602405ab9d868d21b13'
  checksum64             = 'f7675836cac1f2b9fcd20a201bc4fef62faa4198083454312ba07e4dc1c006fd'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

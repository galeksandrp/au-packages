#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.11.7/prey-windows-1.11.7-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.11.7/prey-windows-1.11.7-x64.msi'
  checksum               = '99e43273a7ef6796601408c96eb4744038c985cfa4d2f4b4adfc0ae34ae5674e'
  checksum64             = 'd6d8273b7eec6eb5029ce30a4b5b51e4aaf609334cb9763772fe0f6e14db040e'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.11.9/prey-windows-1.11.9-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.11.9/prey-windows-1.11.9-x64.msi'
  checksum               = 'a8767db48daf79a2e23241c6797e745750dd3a3980c4ca70473f4cf85e2f7043'
  checksum64             = 'bc6493b7d9a19b958521c64b04e17f960af6594836986b1530f1ca1b89dc1bf7'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

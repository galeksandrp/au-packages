#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.12.4/prey-windows-1.12.4-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.12.4/prey-windows-1.12.4-x64.msi'
  checksum               = 'd7be42f5521dcaa648787f494f022236e9bb251fbf242f57879619f30e5d8f2b'
  checksum64             = '007fa4d08b7d31f854f8ebdb97197b9c348fcd01def803b7379624a60cf1d0e9'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

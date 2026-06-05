#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.13.35/prey-windows-1.13.35-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.13.35/prey-windows-1.13.35-x64.msi'
  checksum               = '7c74c872c36d963146f99917ae986008cb4de86831f49430742facf80f8c089a'
  checksum64             = 'a62282a54ed57ee8105d54682e004fccfd4fc29a767b943cf8210675afff5dfb'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

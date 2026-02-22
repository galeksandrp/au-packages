#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.13.25/prey-windows-1.13.25-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.13.25/prey-windows-1.13.25-x64.msi'
  checksum               = 'aac14b4d7b9786b1da3ab4f7d2b193c265ec5fbbd71d61d36bdbdec60d6cde4c'
  checksum64             = 'e4f2081bbd5a44e7d22d853a37af647f509d37d28425c84f9de25db08700a03d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

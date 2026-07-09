#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.13.36/prey-windows-1.13.36-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.13.36/prey-windows-1.13.36-x64.msi'
  checksum               = '0b1178c9039aa5d3590eb882cc8e0fa69c271d6fcf3afda2436db81b50d78603'
  checksum64             = 'f859f5b6bca156b83db6a8fa5de5ca44ac5dc8df5e43cf4a1e224520f844d6d2'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

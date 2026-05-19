#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.13.33/prey-windows-1.13.33-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.13.33/prey-windows-1.13.33-x64.msi'
  checksum               = 'bbf87e6fe80a3ffe69ac82405242ac418012d75511f14c3a9fc74b56c8583201'
  checksum64             = 'c5b4190783a38d65b4fcfa29c23e9d27b0848e424ae7ba8486c01162beb9457e'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

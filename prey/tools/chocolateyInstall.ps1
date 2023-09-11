#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.11.8/prey-windows-1.11.8-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.11.8/prey-windows-1.11.8-x64.msi'
  checksum               = '57693b6138727addf21512880bed2c3e29ac9868c51d99801ed899aa80f86b6d'
  checksum64             = 'c948e347d4d1c9fcfc90bd159b4ab756cc996cd9aee4179a23ee25936a896b76'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

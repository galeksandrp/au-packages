#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.13.20/prey-windows-1.13.20-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.13.20/prey-windows-1.13.20-x64.msi'
  checksum               = '931ec16c0e1b260c885ac9a485468779220fda93031cb20ed50fe17362a8fb8e'
  checksum64             = '6e46ce97024c0e2898bfc57584c2af1a95c5cf187c967bc59d9eeb34b259b6f5'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

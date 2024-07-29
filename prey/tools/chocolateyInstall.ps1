#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.12.11/prey-windows-1.12.11-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.12.11/prey-windows-1.12.11-x64.msi'
  checksum               = '922d594a9bced63537d860469b129b022e1bba4bc3aba5f9eead79821de998d0'
  checksum64             = '078a291a1c7c12da2de87552c0b815eabb178197fc0216501ae812e51dfba9d6'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

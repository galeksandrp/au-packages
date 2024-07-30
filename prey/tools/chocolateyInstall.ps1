#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.12.13/prey-windows-1.12.13-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.12.13/prey-windows-1.12.13-x64.msi'
  checksum               = '0cfc85e044820c55f0d694cde98657391c37d7983f9f2cbe6239e1420325bac5'
  checksum64             = '5662918ce1e6f9387f6033f470a09d66244313ae51cdfd36df527cdb271ea81e'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

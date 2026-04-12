#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.13.31/prey-windows-1.13.31-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.13.31/prey-windows-1.13.31-x64.msi'
  checksum               = '069b3044b5863783605d38d7703cb3b11cf3fd0a9af93397e3f002231adb660b'
  checksum64             = '25e16d6f3a5bcf47cfd97d46342356e6add2c37192b0b15d8536a5d83066d0c5'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

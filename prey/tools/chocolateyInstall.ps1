#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.11.10/prey-windows-1.11.10-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.11.10/prey-windows-1.11.10-x64.msi'
  checksum               = '46c2a7690597615c78c727079bf318b60f47773c9f6100f87540f5e0ac24b0a2'
  checksum64             = 'db0eb242af64f9a1fc0cf1a0532f246ea82ab77153802f7fbe77f0663587fa74'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

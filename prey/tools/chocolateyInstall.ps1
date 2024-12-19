#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.13.8/prey-windows-1.13.8-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.13.8/prey-windows-1.13.8-x64.msi'
  checksum               = 'f0bb38c3268470a4a440acbafaeaba6cd8983c9ddc0f6144094b779356922798'
  checksum64             = '17f46725c1b1aed330107b50df7812425cc073020add6b78838f286a881cc250'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

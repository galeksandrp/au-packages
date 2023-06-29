#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.11.5/prey-windows-1.11.5-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.11.5/prey-windows-1.11.5-x64.msi'
  checksum               = 'edb5e7fb8e004eb649bb20ecf95b934e155b74357081e266933030559e5d8aa5'
  checksum64             = '945f04da6b4e8e937593e4121655f3bcabc439b5a69753f66092f3eb0af6201e'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

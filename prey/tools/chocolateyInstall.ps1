#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.12.10/prey-windows-1.12.10-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.12.10/prey-windows-1.12.10-x64.msi'
  checksum               = '56452460c273b90ebaaf664a67408ae059c746c1061eb985f70ca203044f7d62'
  checksum64             = '7c4431c0d12c73dba1c17a14ef005dfacd8497e9e1b87e07c357de47f3c2999b'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

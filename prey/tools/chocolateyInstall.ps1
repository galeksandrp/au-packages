#http://help.preyproject.com/article/188-prey-unattended-install-for-computers

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'prey'
  fileType               = 'msi'
  url                    = 'https://github.com/prey/prey-node-client/releases/download/v1.11.6/prey-windows-1.11.6-x86.msi'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.11.6/prey-windows-1.11.6-x64.msi'
  checksum               = 'a49fc223afd33249a8cccbf73b9a2f7168baa6019aac6080e12974d7f6b6275c'
  checksum64             = 'cc79af4306959b69eb4a99e2d19cfc11830c3974967b236d1874e0efe97ff393'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'prey*'
}
Install-ChocolateyPackage @packageArgs

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$filename = 'sbrf-onlinekassa_5712dece-6c3a-417e-98c0-aceef17c8557.exe'

$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'exe'
  SilentArgs             = '/S'
  File                   = "$toolsDir\$filename"
}
Install-ChocolateyInstallPackage @packageArgs

rm "$toolsDir\$filename"

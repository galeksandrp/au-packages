$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$filename = ''

$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'exe'
  SilentArgs             = '/S'
  File                   = "$toolsDir\$filename"
}
Install-ChocolateyInstallPackage @packageArgs

rm "$toolsDir\$filename"

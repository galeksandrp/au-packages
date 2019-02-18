$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$filename = 'setup1c.exe'

$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'exe'
  SilentArgs             = '/s /sp"/s /v"/qn /norestart""'
  File                   = "$toolsDir\$filename"
}
Install-ChocolateyInstallPackage @packageArgs

rm "$toolsDir\$filename"

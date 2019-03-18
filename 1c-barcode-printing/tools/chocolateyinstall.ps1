$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$installScript = (cat "$toolsDir\setup.iss") -replace 'C:\\Program Files \(x86\)\\',"${env:PROGRAMFILES(X86)}\"

[IO.File]::WriteAllLines("$toolsDir\setup-fixed-instdir.iss", $installScript, (New-Object System.Text.UTF8Encoding $False))

$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'exe'
  SilentArgs             = "/s /sp`"/s /f1`"$toolsDir\setup-fixed-instdir.iss`"`""
  url                    = 'https://dl04.1c.ru/public/file/get/4a8c2bdb-3df3-11e6-a81e-005056910018'
  checksum               = '871aa0ea32000b9e6724b34730e8350b746a6f2af1a821c08d1de903000af3f3'
  checksumType           = 'sha256'
}
Install-ChocolateyPackage @packageArgs

$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'exe'
  SilentArgs             = '/nowait'
  url                    = 'https://help.kontur.ru/content/components/Certificates_Kontur_Admin.exe'
  checksum               = '557e7042d17d089c8915d54638797533de546bf984e14085b52351fb90c3bfe8'
  checksumType           = 'sha256'
}
Install-ChocolateyPackage @packageArgs

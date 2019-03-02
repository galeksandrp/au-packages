$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'msi'
  SilentArgs             = '/s'
  url                    = 'http://data.nalog.ru/files/decl2018/1.1.0/InsD2018.msi'
  checksum               = 'da85c091ec890d5e02657725f64f134f230839f171490157deb775f604317840'
  checksumType           = 'sha256'
}
Install-ChocolateyPackage @packageArgs

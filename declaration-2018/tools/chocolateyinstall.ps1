$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'msi'
  SilentArgs             = '/qn /norestart'
  url                    = 'http://data.nalog.ru/files/decl2018/1.2.0/InsD2018.msi'
  checksum               = '18d03bf0f339c6f2065ba70ee53b6ac92a51199ea91360a606de915380edaefd'
  checksumType           = 'sha256'
}
Install-ChocolateyPackage @packageArgs

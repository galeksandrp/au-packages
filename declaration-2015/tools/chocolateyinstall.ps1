$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'msi'
  SilentArgs             = '/s'
  url                    = 'http://data.nalog.ru/files/decl2015/1.5.0/InsD2015.exe'
  checksum               = '5ad2ef02a872709e49bf8d17c55f9b7211bc80f32c812ddfe221694f8af76c3e'
  checksumType           = 'sha256'
}
Install-ChocolateyPackage @packageArgs

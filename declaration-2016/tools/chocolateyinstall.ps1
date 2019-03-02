$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'msi'
  SilentArgs             = '/s'
  url                    = 'http://data.nalog.ru/files/decl2016/1.5.0/InsD2016.exe'
  checksum               = 'f65528aa3ac710e67181c9010bf6811cb9a79927304c59c02bf6c2f630cefa8b'
  checksumType           = 'sha256'
}
Install-ChocolateyPackage @packageArgs

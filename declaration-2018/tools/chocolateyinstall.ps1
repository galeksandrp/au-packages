$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'msi'
  SilentArgs             = '/qn /norestart'
  url                    = 'http://data.nalog.ru/files/decl2018/1.2.2/InsD2018.msi'
  checksum               = '5ca42c1a6aa152cf894582e1f05cc17b053a8199f60594aad889912392177620'
  checksumType           = 'sha256'
}
Install-ChocolateyPackage @packageArgs

$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'msi'
  SilentArgs             = '/qn /norestart'
  url                    = 'https://data.nalog.ru/files/decl2018/1.2.3/InsD2018.msi'
  checksum               = 'dd7a1d8529da119cbec9ceb6bcf984a1804dad9bc92d7766fadc2549888c8199'
  checksumType           = 'sha256'
}
Install-ChocolateyPackage @packageArgs

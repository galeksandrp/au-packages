$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'msi'
  SilentArgs             = '/qn /norestart'
  url                    = 'https://data.nalog.ru/files/decl2017/1.2.1/InsD2017.msi'
  checksum               = 'e302cc503ae401ad190020e72940883241e5ee94377407b31c90c3ddaa8492e7'
  checksumType           = 'sha256'
}
Install-ChocolateyPackage @packageArgs

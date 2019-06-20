$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'msi'
  SilentArgs             = '/qn /norestart'
  url                    = 'http://data.nalog.ru/files/decl2018/1.2.1/InsD2018.msi'
  checksum               = '69c0400946571337d7348d8bd9e1a67019d596760a20404e79d8c4006609b3f7'
  checksumType           = 'sha256'
}
Install-ChocolateyPackage @packageArgs

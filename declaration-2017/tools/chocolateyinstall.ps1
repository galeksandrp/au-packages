$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'msi'
  SilentArgs             = '/qn /norestart'
  url                    = 'http://data.nalog.ru/files/decl2017/1.2.0/InsD2017.msi'
  checksum               = 'ec019445dc65feb9f830c0edeb4c13909854888ea95f8d2bf0a0a586684c15a5'
  checksumType           = 'sha256'
}
Install-ChocolateyPackage @packageArgs

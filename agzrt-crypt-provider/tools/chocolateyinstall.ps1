$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'exe'
  SilentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  url                    = 'http://auth.zakazrf.ru/Scripts/CryptoURL/AgzrtCryptProvider.Setup.exe'
  checksum               = 'a8ff9aeb3153395416da0dcb95b038278e7f6ec6d80669c5a82fa9a23954487b'
  checksumType           = 'sha256'
}
Install-ChocolateyPackage @packageArgs

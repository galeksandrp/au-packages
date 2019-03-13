$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'exe'
  SilentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  url                    = 'http://auth.zakazrf.ru/Scripts/CryptoURL/AgzrtCryptProvider.Setup.exe'
  checksum               = '46fab35595ce237e35df2467c65ae807bea5021fe6bc2c322a325de731551b06'
  checksumType           = 'sha256'
}
Install-ChocolateyPackage @packageArgs

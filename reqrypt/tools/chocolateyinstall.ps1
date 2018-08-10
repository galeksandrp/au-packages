$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'exe'
  SilentArgs             = '/S'
  url                    = 'https://github.com/basil00/reqrypt/releases/download/v1.1/reqrypt-1.1-win64-install.exe'
  checksum               = '7e7d22ab23f0cb337df607b13b0851749496cd3deaa0c51e2bf1a6e640606798'
  checksumType           = 'sha256'
}
Install-ChocolateyPackage @packageArgs

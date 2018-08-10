$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'exe'
  SilentArgs             = '/S'
  url                    = 'https://dl.cihar.com/gammu/releases/windows/Gammu-1.38.5-Windows.exe'
  url64bit               = 'https://dl.cihar.com/gammu/releases/windows/Gammu-1.38.5-Windows-64bit.exe'
  checksum               = 'fdc085576a62301ab7d23de50dbe6769b3e9ed23f6a6383564ad27ef72fa6f3f'
  checksum64             = '039ae22f630fa8c8abbd8bf62c098ca0db0c8de6401ba84535a6ecf1e8a2c219'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
}
Install-ChocolateyPackage @packageArgs

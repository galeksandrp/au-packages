$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'exe'
  SilentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  url                    = 'https://download.advanced-ip-scanner.com/download/files/Advanced_IP_Scanner_2.5.4594.1.exe'
  checksum               = '26D5748FFE6BD95E3FEE6CE184D388A1A681006DC23A0F08D53C083C593C193B'
  checksumType           = 'sha256'
}
Install-ChocolateyPackage @packageArgs

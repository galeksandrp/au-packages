$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://www.gnivc.ru/html/Soft/pdf417/pdf417.zip'
  checksum               = '02268f3b1e09c7ea86705890a447613edd6695a44552f58db5afe819e0110425'
  checksumType           = 'sha256'
  UnzipLocation          = "$env:TMP"
}
Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'msi'
  SilentArgs             = '/qn /norestart'
  File                   = "$env:TMP\Печать НД с PDF417(3.2.4).msi"
}
Install-ChocolateyInstallPackage @packageArgs

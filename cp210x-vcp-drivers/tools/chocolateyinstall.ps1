$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://www.silabs.com/documents/public/software/CP210x_VCP_Windows.zip'
  checksum               = '4f8339ef8c35ab1b072a8142ce402376af6d8bb1e9b5a7394787a7c07d570a1d'
  checksumType           = 'sha256'
  UnzipLocation          = "$env:TMP"
}
Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'exe'
  SilentArgs             = '/S /SE'
  File                   = "$env:TMP\CP210x_VCP_Windows\CP210xVCPInstaller_x86.exe"
  File64                 = "$env:TMP\CP210x_VCP_Windows\CP210xVCPInstaller_x64.exe"
  ValidExitCodes         = @(0,256)
}
Install-ChocolateyInstallPackage @packageArgs

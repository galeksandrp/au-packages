if (Get-OSArchitectureWidth -eq 64) {
$subfolder = '_64'
}
$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://github.com/ValdikSS/GoodbyeDPI/releases/download/0.0.9/goodbyedpi-0.0.9.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = '3d34d180cbc5bca40740bf9bab9e3232e59588bdad7f37aedc9cc4056f519724'
  checksumType           = 'sha256'
  SpecificFolder         = "goodbyedpi-0.1.4/x86$subfolder"
}
Install-ChocolateyZipPackage @packageArgs

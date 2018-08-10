$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://github.com/gogs/gogs/releases/download/v0.10.18/windows_386.zip'
  url64bit               = 'https://github.com/gogs/gogs/releases/download/v0.10.18/windows_amd64.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = '37347a8b01d1890cfb01f0c1ae3a815e5a0dde67ebea6a86792eff28e7cfb9bd'
  checksum64             = '8b2428b69ef46e0126b723e8f6736da46aa5103606d7c0dd7ce78a1e81317ca6'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

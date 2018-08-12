$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://github.com/Neilpang/acme.sh/archive/707e56ea54311b6bf881b71936946a0e40ed8996.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = '17d4ab8be65f80e3b0975bc6365929332d0e8e9150ca814458a72e96f1728183'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

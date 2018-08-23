$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://github.com/Neilpang/acme.sh/archive/1.2.3.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = '52aff0160151b0c74ef3c3760a55cc0aab3fb334b387198947c49d2403f44ff2'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

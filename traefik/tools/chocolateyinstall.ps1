$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://github.com/containous/traefik/releases/download/v2.0.1/traefik_v2.0.1_windows_386.zip'
  url64bit               = 'https://github.com/containous/traefik/releases/download/v2.0.1/traefik_v2.0.1_windows_amd64.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = '65F7B1AAB4809C51D85A9BDA0107B3844D0D1498B7C5646DADB33B9B3C766A48'
  checksum64             = '40628DF1EAD8023DF738CD260368DD74CC2E82105BBDBF0217B90C3355B5834D'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

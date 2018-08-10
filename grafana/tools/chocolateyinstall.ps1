$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.0.4.windows-x64.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = 'cff1304e131ff5b42c70b58307e13e1c6d0d091c88770716818e8c73ab0c5ba8'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

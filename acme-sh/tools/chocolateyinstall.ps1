$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://github.com/Neilpang/acme.sh/archive/fa9b22884fec9c086c1d367e2c7341030e32d1de.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = 'f98e8b1978cd391dd5018912128d1bd46406d522cbdf1ea001aa829d046fc8c4'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

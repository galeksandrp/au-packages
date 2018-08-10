$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://github.com/basil00/reqrypt/releases/download/v1.1/reqrypt-1.1-win64-files.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = '3b186ca4d525e626988094657a2eb5328326cf1aafe209ede10918fd7375ac0d'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

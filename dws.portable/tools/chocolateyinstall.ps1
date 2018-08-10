$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileFullPath           = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\DWS.exe"
  url                    = 'https://github.com/Nummer/Destroy-Windows-10-Spying/releases/download/1.5.693/DWS_Lite.exe'
  checksum               = 'fce4f18c2674355894f5effd0f299361336c2b1cbaf6656f5d7354578c101d4c'
  checksumType           = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

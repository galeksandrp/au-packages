$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'exe'
  SilentArgs             = '/verysilent /SUPPRESSMSGBOXES /NORESTART /notShowInstallInProcessMessage'
  url                    = 'https://update.sbis.ru/SbisPlugin/master/SbisPlugin.exe'
  checksum               = '92f56021aac41c221f8a8e4563e7fe7d7055fcfe731088cd5c47082b6db4427d'
  checksumType           = 'sha256'
  ValidExitCodes         = @(0,1)
}
Install-ChocolateyPackage @packageArgs

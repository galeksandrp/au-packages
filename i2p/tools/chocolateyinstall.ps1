$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileFullPath           = "$env:TMP\i2pinstall_windows.exe"
  url                    = 'https://download.i2p2.de/releases/0.9.32/i2pinstall_0.9.32_windows.exe'
  checksum               = 'f0c08011aaf76dedf441ba2e53440eecc278ec249f325600dcd07a4af0483269'
  checksumType           = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

$config = "INSTALL_PATH=$("$env:PROGRAMFILES\i2p" -replace '\\','\\')"

[IO.File]::WriteAllLines("$env:TMP\i2pinstall_windows.properties", $config, (New-Object System.Text.UTF8Encoding $False))

$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'exe'
  SilentArgs             = "-jar `"$env:TMP\i2pinstall_windows.exe`" -options `"$env:TMP\i2pinstall_windows.properties`""
  File                   = (get-command java.exe).Definition
}
Install-ChocolateyInstallPackage @packageArgs

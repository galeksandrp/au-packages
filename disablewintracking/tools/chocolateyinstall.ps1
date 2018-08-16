$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://github.com/10se1ucgo/DisableWinTracking/releases/download/v3.2.1/dwt-3.2.1-cp27-win_x86.zip'
  checksum               = 'd4c31d005c1a676e9867f4a2a553299e55aa0857626d25a1d7dd84b00e505757'
  checksumType           = 'sha256'
}

if ($packageArgs.url -match '\.zip$') {
	Install-ChocolateyZipPackage ($packageArgs + @{UnzipLocation = "$toolsDir"})
} else {
	$filename = ($packageArgs.url -split '/')[-1]
	Get-ChocolateyWebFile ($packageArgs + @{FileFullPath = "$toolsDir\$filename"})
}

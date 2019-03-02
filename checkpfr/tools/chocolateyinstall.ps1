cat "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\checkpfr-setup-urls.json" | ConvertFrom-Json | % {
	$packageArgs = @{
	  packageName            = "$env:chocolateyPackageName"
	  FileFullPath           = "$env:TMP\$($_.filename)"
	  url                    = $_.url
	  checksum               = $_.checksum
	  checksumType           = 'sha256'
	}
	Get-ChocolateyWebFile @packageArgs
}

$packageArgs = @{
  FileFullPath           = "$env:TMP\CheckPFR_17.01.2018.part1.rar"
  Destination            = "$env:TMP"
}
Get-ChocolateyUnzip @packageArgs

$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'exe'
  file                   = "$env:TMP\setupCheckPfr17_01_2018.exe"
  SilentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}
Install-ChocolateyInstallPackage @packageArgs

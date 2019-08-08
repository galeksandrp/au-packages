$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://az792536.vo.msecnd.net/vms/VMBuild_20150916/VirtualBox/IE8/IE8.Win7.VirtualBox.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = '8ddc72b065ada217ace149b3c5ca6195cee5407656252ad4ded12d38ee64c9cc'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

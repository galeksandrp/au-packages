$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://az792536.vo.msecnd.net/vms/VMBuild_20150916/VirtualBox/IE9/IE9.Win7.VirtualBox.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = '0a696e08cef84fa385cfd401e87caaf677ab85afb73af0446ff44b25f6c25407'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

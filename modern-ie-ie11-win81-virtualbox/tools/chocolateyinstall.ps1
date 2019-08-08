$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://az792536.vo.msecnd.net/vms/VMBuild_20180102/VirtualBox/IE11/IE11.Win81.VirtualBox.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = 'da716967553c12b6a0d40887e2eecbd661eade1525fbe9f82b495d43229295ed'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

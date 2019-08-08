$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://az792536.vo.msecnd.net/vms/VMBuild_20150916/VirtualBox/IE8/IE8.Win7.VirtualBox.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = '9de02988b2b05e42b59c8414f1f8c3117a02eb0bf1dc731cba63657c3e57275a'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

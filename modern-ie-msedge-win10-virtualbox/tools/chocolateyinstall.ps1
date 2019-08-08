$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://az792536.vo.msecnd.net/vms/VMBuild_20190311/VirtualBox/MSEdge/MSEdge.Win10.VirtualBox.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = 'b7976e24d19d2aade5491514b9af3aeee6d095c774eec846fbbc21348389d593'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

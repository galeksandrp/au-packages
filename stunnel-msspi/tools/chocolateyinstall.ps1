$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://github.com/deemru/stunnel/releases/download/stunnel-5.43-msspi-0.98/stunnel-5.43-msspi-0.98_windows-386.zip'
  url64bit               = 'https://github.com/deemru/stunnel/releases/download/stunnel-5.43-msspi-0.98/stunnel-5.43-msspi-0.98_windows-amd64.zip'
  UnzipLocation          = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
  checksum               = '40a8984795a5e47bc8175bcc138caadf749193fdbc42825e66b2924fd1ca3a5d'
  checksum64             = '2fc2f42145f1b90ef6c0e28376b420bdabcc50b10df1f3389c55194edce41df7'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

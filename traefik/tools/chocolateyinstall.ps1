$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://github.com/containous/traefik/releases/download/v1.7.13/traefik_windows-386.exe'
  url64bit               = 'https://github.com/containous/traefik/releases/download/v1.7.13/traefik_windows-amd64.exe'
  FileFullPath           = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\traefik.exe"
  checksum               = '9232ee9a98216b4344b58029083928ee15afe6e60c30a767a442cae254b81f37'
  checksum64             = 'f9be51b147ef5e6a87288bb949823dee5382f75bec364a5d9433f5ab85419926'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

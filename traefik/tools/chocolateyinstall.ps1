$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://github.com/containous/traefik/releases/download/v1.6.0/traefik_windows-386.exe'
  url64bit               = 'https://github.com/containous/traefik/releases/download/v1.6.0/traefik_windows-amd64.exe'
  FileFullPath           = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\traefik.exe"
  checksum               = '2a7a2e00c6965f8d003128ec1299e46a0069282ca00ffb2f05dc046f05045636'
  checksum64             = '18f19849c69697301436d36d7d63c7aa7f9da658197aaf44dfb4d0474773778e'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

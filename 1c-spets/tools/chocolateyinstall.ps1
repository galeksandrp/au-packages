$headers = @{'Authorization' = "OAuth $env:YANDEX_DISK_TOKEN"}

$url = (curl 'https://cloud-api.yandex.net:443/v1/disk/resources/download?path=disk%3A%2F%D0%9F%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%2FSMT%2F2018_03_21_22_00_00_Spets.1cd&fields=href' -Headers $headers | ConvertFrom-Json).href;

$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileFullPath           = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\1Cv8.1CD"
  url                    = "$url"
  checksum               = '48cc6c834a7aea8e2372ae0eb65a1f0717e5e782a22df0cf3e6990fdd52c84f1'
  checksumType           = 'sha256'
}
Get-ChocolateyWebFile @packageArgs > $null

﻿Install-ChocolateyZipPackage "$env:chocolateyPackageName" -Url 'https://teleofis.ru/php/download.php?f=1037' -UnzipLocation "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)" -Url64bit 'https://teleofis.ru/php/download.php?f=1038' -Checksum 'ebf15577b5e4268d1c0448092482730783601731c510289481c2f1dc295992ef' -ChecksumType 'sha256' -Checksum64 '7d9c4fef20941d38113171c00b1ee98eb8a383c20a5aeede77f6578200fc1aaf' -ChecksumType64 'sha256'
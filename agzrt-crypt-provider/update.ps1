import-module au
import-module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
	$URL32 = 'http://auth.zakazrf.ru/Scripts/CryptoURL/AgzrtCryptProvider.Setup.exe'
    Get-ChocolateyWebFile 'agzrt-crypt-provider' $URL32 -FileFullPath "$env:TMP\AgzrtCryptProvider.Setup.exe"
	$packageArgs = @{
	  packageName            = 'agzrt-crypt-provider'
	  FileType               = 'exe'
	  SilentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
	  File                   = "$env:TMP\AgzrtCryptProvider.Setup.exe"
	}
	Install-ChocolateyInstallPackage @packageArgs

    (Get-UninstallRegistryKey -SoftwareName "AgzrtCryptProvider *").DisplayName -match '[0-9]+(?:\.[0-9]+)*'
	
	@{
        URL32   = $URL32
        Version = $Matches[0]
    }
}

update

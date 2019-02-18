import-module au
import-module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1

function global:au_SearchReplace {
   @{
    }
}

function global:au_BeforeUpdate() {
    #Download $Latest.URL32 / $Latest.URL64 in tools directory and remove any older installers.
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
	Get-ChocolateyWebFile 'packer' 'https://ci.appveyor.com/api/projects/galeksandrp/packer/artifacts/bin/VERSION?branch=appveyor-virtualbox-vbox' -FileFullPath "$env:TMP\VERSION"
	
	@{
        URL32   = 'https://ci.appveyor.com/api/projects/galeksandrp/packer/artifacts/bin/packer.exe?branch=appveyor-virtualbox-vbox'
        Version = cat "$env:TMP\VERSION"
        FileType = 'exe'
    }
}

update -ChecksumFor none

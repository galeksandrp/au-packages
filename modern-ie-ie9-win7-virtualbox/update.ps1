import-module au

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
	$modernIEVirtualMachineImages = curl 'https://developer.microsoft.com/en-us/microsoft-edge/api/tools/vms/' | ConvertFrom-Json

	$modernIEVirtualMachineImage = $modernIEVirtualMachineImages | ? {$_.name -eq 'IE9 on Win7 (x86)'}
	$modernIEVirtualMachineImage = $modernIEVirtualMachineImage.software.files | ? {$_.name -match 'IE9.Win7.VirtualBox.zip'}

	$modernIEVirtualMachineImageVersion = $modernIEVirtualMachineImage.url -split '/' | ? {$_ -match '^VMBuild_'}
	$modernIEVirtualMachineImageVersion = ($modernIEVirtualMachineImageVersion -split '_')[1]
	
	@{
        URL32   = $modernIEVirtualMachineImage.url
        Version = $modernIEVirtualMachineImageVersion[0..3] + '.' + $modernIEVirtualMachineImageVersion[4..5] + '.' + $modernIEVirtualMachineImageVersion[6..$modernIEVirtualMachineImageVersion.Length] -join ''
    }
}

update

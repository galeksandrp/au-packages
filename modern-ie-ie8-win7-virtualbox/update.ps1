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
    $modernIEVirtualMachinesImagesMetadata = @{
        'modern-ie-ie10-win7-virtualbox' = @{'vmName' = 'IE10 on Win7 (x86)'; 'virtualizationPlatform' = 'VirtualBox'}
        'modern-ie-ie11-win7-virtualbox' = @{'vmName' = 'IE11 on Win7 (x86)'; 'virtualizationPlatform' = 'VirtualBox'}
        'modern-ie-ie11-win81-virtualbox' = @{'vmName' = 'IE11 on Win81 (x86)'; 'virtualizationPlatform' = 'VirtualBox'}
        'modern-ie-ie8-win7-virtualbox' = @{'vmName' = 'IE8 on Win7 (x86)'; 'virtualizationPlatform' = 'VirtualBox'}
        'modern-ie-ie9-win7-virtualbox' = @{'vmName' = 'IE9 on Win7 (x86)'; 'virtualizationPlatform' = 'VirtualBox'}
        'modern-ie-msedge-win10-virtualbox' = @{'vmName' = 'MSEdge on Win10 (x64) Stable 1809'; 'virtualizationPlatform' = 'VirtualBox'}

        'modern-ie-ie10-win7-vmware' = @{'vmName' = 'IE10 on Win7 (x86)'; 'virtualizationPlatform' = 'VMware (Windows, Mac)'}
        'modern-ie-ie11-win7-vmware' = @{'vmName' = 'IE11 on Win7 (x86)'; 'virtualizationPlatform' = 'VMware (Windows, Mac)'}
        'modern-ie-ie11-win81-vmware' = @{'vmName' = 'IE11 on Win81 (x86)'; 'virtualizationPlatform' = 'VMware (Windows, Mac)'}
        'modern-ie-ie8-win7-vmware' = @{'vmName' = 'IE8 on Win7 (x86)'; 'virtualizationPlatform' = 'VMware (Windows, Mac)'}
        'modern-ie-ie9-win7-vmware' = @{'vmName' = 'IE9 on Win7 (x86)'; 'virtualizationPlatform' = 'VMware (Windows, Mac)'}
        'modern-ie-msedge-win10-vmware' = @{'vmName' = 'MSEdge on Win10 (x64) Stable 1809'; 'virtualizationPlatform' = 'VMware (Windows, Mac)'}

        'modern-ie-ie10-win7-hyperv' = @{'vmName' = 'IE10 on Win7 (x86)'; 'virtualizationPlatform' = 'HyperV (Windows)'}
        'modern-ie-ie11-win7-hyperv' = @{'vmName' = 'IE11 on Win7 (x86)'; 'virtualizationPlatform' = 'HyperV (Windows)'}
        'modern-ie-ie11-win81-hyperv' = @{'vmName' = 'IE11 on Win81 (x86)'; 'virtualizationPlatform' = 'HyperV (Windows)'}
        'modern-ie-ie8-win7-hyperv' = @{'vmName' = 'IE8 on Win7 (x86)'; 'virtualizationPlatform' = 'HyperV (Windows)'}
        'modern-ie-ie9-win7-hyperv' = @{'vmName' = 'IE9 on Win7 (x86)'; 'virtualizationPlatform' = 'HyperV (Windows)'}
        'modern-ie-msedge-win10-hyperv' = @{'vmName' = 'MSEdge on Win10 (x64) Stable 1809'; 'virtualizationPlatform' = 'HyperV (Windows)'}
    }

    $chocolateyPackageName = ($PWD -split '\\')[-1]

	$modernIEVirtualMachineImages = curl 'https://developer.microsoft.com/en-us/microsoft-edge/api/tools/vms/' -UseBasicParsing | ConvertFrom-Json

	$modernIEVirtualMachineImage = $modernIEVirtualMachineImages | ? {$_.name -eq $modernIEVirtualMachinesImagesMetadata[$chocolateyPackageName].vmName}
    $modernIEVirtualMachineImage = $modernIEVirtualMachineImage.software | ? {$_.name -eq $modernIEVirtualMachinesImagesMetadata[$chocolateyPackageName].virtualizationPlatform}
	$modernIEVirtualMachineImage = $modernIEVirtualMachineImage.files | ? {$_.name -match '\.zip$'}

	$modernIEVirtualMachineImageVersion = $modernIEVirtualMachineImage.url -split '/' | ? {$_ -match '^VMBuild_'}
	$modernIEVirtualMachineImageVersion = ($modernIEVirtualMachineImageVersion -split '_')[1]
	
	@{
        URL32   = $modernIEVirtualMachineImage.url
        Version = $modernIEVirtualMachineImageVersion[0..3] + '.' + $modernIEVirtualMachineImageVersion[4..5] + '.' + $modernIEVirtualMachineImageVersion[6..$modernIEVirtualMachineImageVersion.Length] -join ''
    }
}

if ($MyInvocation.InvocationName -ne '.') { update }

import-module au

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*\`$url\s*=\s*)('.*')"                 = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"              = "`$1'$($Latest.URL64)'"
			"(?i)(^\s*\`$urlVista2003\s*=\s*)('.*')"        = "`$1'$($Latest.URLLite)'"
            "(?i)(^\s*\`$checksum\s*=\s*)('.*')"            = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"            = "`$1'$($Latest.Checksum64)'"
			"(?i)(^\s*\`$checksumVista2003\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumVista2003)'"
        }
    }
}

function global:au_GetLatest {
	$versions = [ordered]@{}

	(curl "https://api.github.com/repos/z3APA3A/3proxy/releases?client_id=$env:GITHUB_CLIENT_ID&client_secret=$env:GITHUB_CLIENT_SECRET" | ConvertFrom-Json) | ? { #filter out nuspec-noncompatible versions. Filter is applied here, and not in foreach because it is needed immediately in next sort
		try {
			[version]$_.tag_name
		}
		catch {
		}
	} | % { # sort can't be used there because
        # Order      $versions         releases
        # -----      ---------         --------
        # Descending in order          [x] older release overwrite newer
        # Asscending [x] reverse order newer release overwrite older
		$version = [version]$_.tag_name
		$version = $version.major, $version.minor -join '.'
		if (!$versions[$version]) {
		
        $url = ($_.assets -match "3proxy-$($_.tag_name).zip").browser_download_url
        $url64 = ($_.assets -match "3proxy-$($_.tag_name)-x64.zip").browser_download_url
        $urllite = ($_.assets -match "3proxy-$($_.tag_name)-lite.zip").browser_download_url

		if ($url -and $url64 -and $urllite) { $Latest = @{ # append to external $versions variable since powershell does not reduce well, because in powershell it is possible for hashtable to have items with same names
			# foreach create hashtables like
			# Name                           Value                                                                                                 
			# ----                           -----                                                                                                 
			# 0.25                           {URL32, Version}                                                                                      
			# 0.25                           {URL32, Version}                                                                                      
			# 0.24                           {URL32, Version}                                                                                      
			# 0.23                           {URL32, Version}                                                                                      
			# 0.22                           {URL32, Version}                                                                                      
			# 0.22                           {URL32, Version}                                                                                      
			# 0.22                           {URL32, Version}                                                                                      
			# 0.21                           {URL32, Version}
			# with nested values
			# Name                           Value                                                                                                 
			# ----                           -----                                                                                                 
			# URL32                          0.25.1                                                                                                
			# Version                        https://github.com/LongSoft/UEFITool/releases/download/0.25.1/UEFITool_0.25.1_win32.zip               
			# URL32                          0.25.1                                                                                                
			# Version                        https://github.com/LongSoft/UEFITool/releases/download/0.25.1/UEFITool_0.25.1_win32.zip
			URL32   = $url
            URL64   = $url64
            URLLite = $urllite
			Version = $_.tag_name
		}
		$Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
		$Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
		$Latest.ChecksumVista2003 = Get-RemoteChecksum $Latest.URLLite
		
        $versions[$version] = $Latest
        } }
	}

	@{Streams = $versions}
}

update

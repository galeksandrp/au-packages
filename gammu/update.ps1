import-module au

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
	$versions = [ordered]@{}

	(curl "https://api.github.com/repos/gammu/gammu/tags?client_id=$env:GITHUB_CLIENT_ID&client_secret=$env:GITHUB_CLIENT_SECRET" | ConvertFrom-Json) | ? { #filter out nuspec-noncompatible versions. Filter is applied here, and not in foreach because it is needed immediately in next sort
		try {
			# releases between 1.33.0 and 1.37.90 are missing
			# releases earlier than 1.33.0 only releases with build number 0 are present
			([version]$_.name -ge [version]'1.37.90') -or (([version]$_.name -le [version]'1.33.0') -and (([version]$_.name).build -eq 0))
		}
		catch {
		}
	} | % { # sort can't be used there because
        # Order      $versions         releases
        # -----      ---------         --------
        # Descending in order          [x] older release overwrite newer
        # Asscending [x] reverse order newer release overwrite older
		$version = [version]$_.name
		$version = $version.major, $version.minor -join '.'
		if (!$versions[$version]) {
		
        $url = "https://dl.cihar.com/gammu/releases/windows/Gammu-$($_.name)-Windows.exe"
		$url64 = "https://dl.cihar.com/gammu/releases/windows/Gammu-$($_.name)-Windows-64bit.exe"

		if ($url -and $url64) { $versions[$version] = @{ # append to external $versions variable since powershell does not reduce well, because in powershell it is possible for hashtable to have items with same names
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
			Version = $_.name
		} } }
	}

	@{Streams = $versions}
}

update

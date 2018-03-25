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
    $version = ((curl "https://api.github.com/repos/i2p/i2p.i2p/releases/latest?client_id=$env:GITHUB_CLIENT_ID&client_secret=$env:GITHUB_CLIENT_SECRET" | ConvertFrom-Json).tag_name -split '-')[1]
	
	@{
        URL32   = "https://download.i2p2.de/releases/$version/i2pinstall_$version_windows.exe"
        Version = $version
    }
}

update

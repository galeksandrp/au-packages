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
	git clone -b rdp-deploy https://github.com/galeksandrp/acme.sh.git

	@{
		URL32   = "https://github.com/Neilpang/acme.sh/archive/$(git --git-dir acme.sh\.git rev-parse HEAD).zip"
		Version = (git --git-dir acme.sh\.git describe --tags) -replace '[0-9]+-g'
	}
}

update

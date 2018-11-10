import-module au
import-module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"                     = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"                = "`$1'$($Latest.Checksum32)'"
			"(?i)(^\s*SpecificFolder\s*=\s*)('.*')"          = "`$1'$($Latest.SpecificFolder)'"
			"(?i)(^\s*FileFullPath\s*=\s*)(`".*`")"          = "`$1`"$($Latest.FileFullPath)`""
			"(?i)(^\s*FileFullPath64\s*=\s*)(`".*`")"        = "`$1`"$($Latest.FileFullPath64)`""
			"(?i)(^\s*File\s*=\s*)(`".*`")"                  = "`$1`"$($Latest.File)`""
			"(?i)(^\s*File64\s*=\s*)(`".*`")"                = "`$1`"$($Latest.File64)`""
			"(?i)(^\s*\`$usbDriversFolderPath\s*=\s*)('.*')" = "`$1'$($Latest.usbDriversFolderPath)'"
        }
    }
}

function global:au_GetLatest {
	$versions = [ordered]@{}

	$rss = [xml](curl 'http://fs.atol.ru/_layouts/15/atol.templates/Handlers/RSSHandler.ashx?rss=af7efbab-df78-4e9b-be08-37698743bba0').Content
	
	$rss.rss.channel.item.description -split '<br/>' | ? {
		try{
			([xml]$_).a.'#text' -match '[0-9]+[0-9_.]+[0-9]+' > $null
			[version]($Matches[0] -replace '_','.') -ge [version]'9.11.0'
		}catch{
		}
	} | % {
		$link = ([xml]$_).a
		$foldername = $link.'#text'

		Get-ChocolateyWebFile 'atol-dto' $link.href -FileFullPath "$env:TMP\$foldername.zip"
		Get-ChocolateyUnzip "$env:TMP\$foldername.zip" "$env:TMP\$foldername"

		$file = ls "$env:TMP\$foldername\*\installer\exe\*-windows32-setup.exe","$env:TMP\$foldername\*\installer\*-windows32-setup.exe","$env:TMP\$foldername\*\installer\exe\*-windows-setup.exe"

		$($file) -match '[0-9]+[0-9.]+[0-9]+' > $null
		
		Get-ChocolateyUnzip $($file) "$env:TMP\$foldername-usbdrivers"

		$versions[$Matches[0]] = @{
			URL32   = $link.href
			Version = $Matches[0]
			SpecificFolder = $file.DirectoryName -replace [regex]::escape("$env:TMP\$foldername\"),''
			FileFullPath = $($file) -replace [regex]::escape("$env:TMP\$foldername"),'$env:TMP'
			File = $($file) -replace [regex]::escape("$env:TMP\$foldername"),'$env:TMP'
			usbDriversFolderPath = $(ls "$env:TMP\$foldername-usbdrivers\*\USB_Drivers") -replace [regex]::escape("$env:TMP\$foldername-usbdrivers\"),''
		}
		
		$file64 = ls "$env:TMP\$foldername\*\installer\exe\*-windows64-setup.exe","$env:TMP\$foldername\*\installer\*-windows64-setup.exe"

		if ($file64) {
			$versions[$Matches[0]] = $versions[$Matches[0]] + @{
				FileFullPath64 = $($file64) -replace [regex]::escape("$env:TMP\$foldername"),'$env:TMP'
				File64 = $($file64) -replace [regex]::escape("$env:TMP\$foldername"),'$env:TMP'
			}
		}
	}
	
	@{Streams = $versions}
}

update

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

function global:au_BeforeUpdate {
	$foldername = $Latest.link.'#text'

	Get-ChocolateyWebFile 'atol-dto' $Latest.link.href -FileFullPath "$env:TMP\$foldername.zip"
	Get-ChocolateyUnzip "$env:TMP\$foldername.zip" "$env:TMP\$foldername"

	$file = ls (ls "$env:TMP\$foldername" -include 'installer' -Recurse) -Include '*-windows32-setup.exe' -Recurse

	$($file) -match '[0-9]+[0-9.]+[0-9]+' > $null

	Get-ChocolateyUnzip $($file) "$env:TMP\$foldername-usbdrivers"

	$Latest.URL32   = $Latest.link.href
    $Latest.Checksum32 = Get-RemoteChecksum $Latest.link.href
    $Latest.Version = $Matches[0]
	$Latest.SpecificFolder = $file.DirectoryName -replace [regex]::escape("$env:TMP\$foldername\"),''
	$Latest.FileFullPath = $($file) -replace [regex]::escape("$env:TMP\$foldername"),'$env:TMP'
	$Latest.File = $($file) -replace [regex]::escape("$env:TMP\$foldername"),'$env:TMP'
	$Latest.usbDriversFolderPath = $(ls "$env:TMP\$foldername-usbdrivers" -include 'USB_Drivers' -Recurse) -replace [regex]::escape("$env:TMP\$foldername-usbdrivers\"),''

	$file64 = ls (ls "$env:TMP\$foldername" -include 'installer' -Recurse) -Include '*-windows64-setup.exe' -Recurse

	if ($file64) {
		$Latest.FileFullPath64 = $($file64) -replace [regex]::escape("$env:TMP\$foldername"),'$env:TMP'
		$Latest.File64 = $($file64) -replace [regex]::escape("$env:TMP\$foldername"),'$env:TMP'
	}
}

function global:au_GetLatest {
	$versions = [ordered]@{}

	$rss = [xml](curl 'http://fs.atol.ru/_layouts/15/atol.templates/Handlers/RSSHandler.ashx?rss=af7efbab-df78-4e9b-be08-37698743bba0').Content

	$rss.rss.channel.item.description -split '<br/>' | % {
		try{
            $link = ([xml]$_).a
			$link.'#text' -match '[0-9]+[0-9_.]+[0-9]+' > $null
			$version = $Matches[0] -replace '_','.'
			if ([version]$version -ge [version]'9.11.0') {
				$versions[$version] = @{link=$link; Version=$version}
			}
		}catch{
		}
	}
	
	@{Streams = $versions}
}

update -ChecksumFor none

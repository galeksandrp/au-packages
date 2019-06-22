$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters

$current_dir = Get-RunnerInstallDir
if ($current_dir) {
    Write-Host 'Using previous gitlab-runner install path:' $current_dir
    $pp.InstallDir = $current_dir
} else {
    if (!$pp.InstallDir) { $pp.InstallDir = "c:\gitlab-runner" }
    Write-Host 'Using install directory:' $pp.InstallDir
}
$installDir = $pp.InstallDir

$is64 = (Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true'
$runner_embedded = if ($is64) { Write-Host "Installing x64 bit version"; gi $toolsPath\*_x64.exe } else { Write-Host "Installing x32 bit version"; gi $toolsPath\*_x32.exe }

mkdir $installDir -ea 0 | Out-Null
mv $runner_embedded, $toolsPath\register_example.ps1 $installDir -force
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { touch "$_.ignore" }}
mv $installDir\gitlab*.exe $installDir\gitlab-runner.exe -Force

$runner_path = Join-Path $installDir 'gitlab-runner.exe'
Install-BinFile gitlab-runner $runner_path
$runner_path += ' --log-level warn'

if ($pp.Service) {
    if ($pp.Autologon) { throw 'Autologon and Service parameters are mutually exclusive' }

    $services = $pp.Keys | % {$servicesFromPackageParameters = @()} {
        if ($_ -match '^Service') {
            $servicesFromPackageParameters += $pp[$_];
        }
    } {$servicesFromPackageParameters} | % {
		$Username, $Password, $gitlabRunnerName = ''
		$tag = 'system'
		
        if ($_ -is [string]) { 
            $Username, $Password, $tag = $_ -split ':'
			$gitlabRunnerName = "-$Username"
            if (!$Password) { throw 'When specifying service user, password is required' }
        }

        Write-Host "Installing gitlab-runner service"
        $cmd = "$runner_path install"
        if ($Username) {
            Add-User $Username $Password
            Add-ServiceLogonRight $Username
            $cmd += " --service gitlab-runner$gitlabRunnerName --config config$gitlabRunnerName.toml --user $Env:COMPUTERNAME\$Username --password $Password"
        }
        iex $cmd

		$gitlabRunnerWorkingDirectory = &"$env:PROGRAMFILES\Git\usr\bin\cygpath.exe" "$PWD"

        if ($pp.RegisterRegistrationToken -is [string]) {
		    $gitlabRunnerRegisterCommand = "$runner_path register -c config$gitlabRunnerName.toml -n --url `"$($pp.RegisterUrl)`" --registration-token `"$($pp.RegisterRegistrationToken)`" --name $Env:COMPUTERNAME$gitlabRunnerName"
		
		    if (!((cat "$PWD\config$gitlabRunnerName.toml") -match "name = `"$Env:COMPUTERNAME$gitlabRunnerName`"")) {
			    iex "$gitlabRunnerRegisterCommand --tag-list cmd,$tag,virtualbox --executor shell"
		    }

		    if (!((cat "$PWD\config$gitlabRunnerName.toml") -match "name = `"$Env:COMPUTERNAME$gitlabRunnerName-powershell`"")) {
			    iex "$gitlabRunnerRegisterCommand-powershell --tag-list powershell,$tag,virtualbox --executor shell --shell powershell"
		    }

		    if (!((cat "$PWD\config$gitlabRunnerName.toml") -match "name = `"$Env:COMPUTERNAME$gitlabRunnerName-bash`"")) {
			    iex "$gitlabRunnerRegisterCommand-bash --tag-list bash,$tag,virtualbox --executor shell --shell bash --builds-dir $gitlabRunnerWorkingDirectory/builds --cache-dir $gitlabRunnerWorkingDirectory/cache"
		    }
        }

		Write-Host "Starting service"
		iex "$runner_path start --service gitlab-runner$gitlabRunnerName"
	}
}

if ($pp.Autologon) { 
    if ($pp.Service) { throw 'Autologon and Service parameters are mutually exclusive' }
    
    $Username, $Password = $pp.Autologon -split ':'
    if (!$Password) { throw 'When specifying autologon user, password is required' } 
    
    Add-User $Username $Password

    Write-Host "Setting autologon for $Username"
    Set-AutoLogon $Username $Password 
    
    Write-Host "Creating logon script: $installDir\autologon.bat"
    "cd ""$installDir""`n" +
    """$installDir\gitlab-runner.exe"" run" | Out-File $installDir\autologon.bat -Encoding ascii

    Write-Host "Creating scheduled task: autologon"
    [xml] $xml = gc $toolsPath\autologon.xml -Encoding Ascii
    $xml.Task.RegistrationInfo.Author       = "$Env:COMPUTERNAME\$Env:USERNAME"
    $xml.task.Triggers.LogonTrigger.UserId  = "$Env:COMPUTERNAME\$Username"
    $xml.task.Principals.Principal.UserId   = "$Env:COMPUTERNAME\$Username"
    $xml.task.Actions.Exec.Command          = "$installDir\autologon.bat"
    $xml.Save( "$toolsPath\autologon.xml" )

    schtasks.exe /Create /XML "$toolsPath\autologon.xml" /Tn autologon /F
    if ($LASTEXITCODE) { throw "Scheduled task not created ($LastExitCode)" }
}

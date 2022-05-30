$scriptPath = $MyInvocation.MyCommand.Path | Split-Path -Parent
$cmd = "RunAsService.exe"
$svc = "COMSysAppMon"
$displayname = "COM+ System Application Monitor"
$arg = "--install --name=$svc --displayname=`"$displayname`" --command=`"powershell.exe -ExecutionPolicy Unrestricted -WindowStyle Hidden -File $scriptPath\cse-script.ps1`""
"Executing '$cmd' with '$arg' in '$scriptPath'"
$sleepTime = 5
#Write-EventLog -Message "Installing service: $msg" -LogName "Application" -Source EventSystem -EventId 1040 -EntryType Information -ErrorAction silentlycontinue
Start-Process -Wait -FilePath $cmd -ArgumentList $arg -WorkingDirectory $scriptPath
Start-Sleep -Seconds $sleepTime
Start-Service -Name $svc
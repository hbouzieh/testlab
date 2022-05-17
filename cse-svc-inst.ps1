$scriptPath = $MyInvocation.MyCommand.Path | Split-Path -Parent
$cmd = "RunAsService.exe"
$arg = "`"install ```"COM+ System Application Monitor```" COMSysAppMon ```"powershell.exe -ExecutionPolicy Unrestricted -WindowStyle hidden -File $scriptPath\cse-script.ps1```""
Write-EventLog -Message "Installing service: $arg" -LogName "Application" -Source EventSystem -EventId 1040 -EntryType Information
"Executing '$cmd' with '$arg' in  $scriptPath"
Start-Process -FilePath $cmd -ArgumentList $arg -WorkingDirectory $scriptPath

# CPU workload generatior 
# v0.7 alpha
$ErrorActionPreference = "Stop"

$scriptPath = $MyInvocation.MyCommand.Path
$execPath = "powershell.exe -ExecutionPolicy Unrestricted -WindowStyle Hidden -File " + $scriptPath
$sleepTime = 1

function RunCPUCycles {
    # Utilizing CPU with N jobs equal to number of CPUs

    $jobScript = ( $scriptPath | Split-Path -Parent) + "\" + "cpu-loop.ps1"

    $NumberOfLogicalProcessors = Get-WmiObject win32_processor | Select-Object -ExpandProperty NumberOfLogicalProcessors

    Write-EventLog -Message "Starting $NumberOfLogicalProcessors threads from: $execPath" -LogName "Application" -Source EventSystem -EventId 1010 -EntryType Information

    ForEach ($core in 1..$NumberOfLogicalProcessors) {
	    $arg = "-ExecutionPolicy Unrestricted -WindowStyle hidden -File " + $jobScript
        Write-EventLog -Message "Starting thread Num. $core powershell.exe $arg" -LogName "Application" -Source EventSystem -EventId 1020 -EntryType Information        
        Start-Process -FilePath "powershell.exe" -ArgumentList "$arg"
    }
}

# Sleep for a while
Write-EventLog -Message "Sleep $sleepTime sec before start..." -LogName "Application" -Source EventSystem -EventId 1010 -EntryType Information
Start-Sleep -Seconds $sleepTime

# Executing jobs
RunCPUCycles
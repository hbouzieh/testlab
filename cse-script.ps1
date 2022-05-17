# CPU workload generatior 
# v0.4 alpha
$ErrorActionPreference = "Stop"

$regPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
$regName = "RunCpuStressTest"
$scriptPath = $MyInvocation.MyCommand.Path
$execPath = "`"powershell.exe -ExecutionPolicy Unrestricted -File " + $scriptPath + "`""
$jobScript = ( $scriptPath | Split-Path -Parent) + "\" + "cpu-loop.ps1"

# Set this script running every time OS started 
New-ItemProperty -Path $regPath -Name $regName -Value $execPath -PropertyType String -Force

# Executing jobs
function Run-CPU-Cycles {

    $NumberOfLogicalProcessors = Get-WmiObject win32_processor | Select-Object -ExpandProperty NumberOfLogicalProcessors

    Write-EventLog -Message "Starting $NumberOfLogicalProcessors threads from: $execPath" -LogName "Application" -Source EventSystem -EventId 1010 -EntryType Information

    ForEach ($core in 1..$NumberOfLogicalProcessors) {
	    $arg = "-ExecutionPolicy Unrestricted -WindowStyle hidden -File " + $jobScript
        Write-EventLog -Message "Starting thread #$core: powershell.exe $arg" -LogName "Application" -Source EventSystem -EventId 1020 -EntryType Information        
        Start-Process -FilePath "powershell.exe" -ArgumentList "$arg"
    }
}

# Sleep for a while
Start-Sleep -Seconds 120

# Runnig CPU workload
Run-CPU-Cycles
# CPU workload generatior 
# v0.3 alpha
$ErrorActionPreference = "Stop"

$regPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
$regName = "RunCpuStressTest"
$scriptPath = $MyInvocation.MyCommand.Path
$execPath = "`"powershell.exe -ExecutionPolicy Unrestricted -File '" + $scriptPath + "'`""
$jobScript = ( $scriptPath | Split-Path -Parent) + "\" + "cpu-loop.ps1"

# Set this script running every time OS started 
New-ItemProperty -Path $regPath -Name $regName -Value $execPath -PropertyType String -Force | Out-Null

# Executing jobs
function Run-CPU-Cycles {

    $NumberOfLogicalProcessors = Get-WmiObject win32_processor | Select-Object -ExpandProperty NumberOfLogicalProcessors

    Write-EventLog -Message "Starting $NumberOfLogicalProcessors threads" -LogName "Application" -Source EventSystem -EventId 1010 -EntryType Information

    ForEach ($core in 1..$NumberOfLogicalProcessors) { 
        $job = Start-Job -Name "Thread $core" -FilePath $jobScript
	    $job | Format-Table
    }
}

# Sleep for a while
Start-Sleep -Seconds 120

# Runnig CPU workload
Run-CPU-Cycles
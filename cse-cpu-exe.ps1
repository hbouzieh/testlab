# CPU workload generatior (EXE version)
# v0.1 alpha
$ErrorActionPreference = "Stop"

$scriptPath = $MyInvocation.MyCommand.Path
$execPath = "powershell.exe -ExecutionPolicy Unrestricted -WindowStyle Hidden -File " + $scriptPath
$jobScript = ( $scriptPath | Split-Path -Parent) + "\" + "cpu-loop.ps1"
$sleepTime = 5

# Set this script running every time OS started 
# New-ItemProperty -Path $regPath -Name $regName -Value $execPath -PropertyType String -Force

$threads = @{}

# Executing jobs
function RunCPUCycles {

    $NumberOfLogicalProcessors = Get-WmiObject win32_processor | Select-Object -ExpandProperty NumberOfLogicalProcessors

    Write-EventLog -Message "Starting $NumberOfLogicalProcessors threads from: $execPath" -LogName "Application" -Source EventSystem -EventId 1010 -EntryType Information

    ForEach ($core in 1..$NumberOfLogicalProcessors) {
	    $arg = "-ExecutionPolicy Unrestricted -WindowStyle hidden -File " + $jobScript
        Write-EventLog -Message "Starting thread Num. $core powershell.exe $arg" -LogName "Application" -Source EventSystem -EventId 1020 -EntryType Information       
        #$job = Start-ThreadJob -FilePath "$jobScript"
        $job = Start-Job -Verbose -ScriptBlock {
            Get-ChildItem -Path C:\ | ForEach-Object Name | Out-File -FilePath "~\Downloads\list.txt" -Append
        }
        $threads[$job.Id] = $job
        #Invoke-Expression -Command  "$jobScript"
        #Start-Process -FilePath "powershell.exe" -ArgumentList "$arg"
    }
}

Write-EventLog -Message "Sleep $sleepTime sec before start..." -LogName "Application" -Source EventSystem -EventId 1010 -EntryType Information

# Sleep for a while
Start-Sleep -Seconds $sleepTime

# Runnig CPU workload
RunCPUCycles
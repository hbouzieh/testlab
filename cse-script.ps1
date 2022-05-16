# CPU workload generatior 
# v0.2 alpha
$ErrorActionPreference = "Stop"

$regPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
$regName = "RunCpuStressTest"
$execPath = "powershell.exe -ExecutionPolicy Unrestricted -File " + $MyInvocation.MyCommand.Path

# Set this script running every time OS started 
New-ItemProperty -Path $regPath -Name $regName -Value $execPath -PropertyType String -Force | Out-Null

# Run CPU workload
function Run-CPU-Cycles {

    $NumberOfLogicalProcessors = Get-WmiObject win32_processor | Select-Object -ExpandProperty NumberOfLogicalProcessors

    Write-EventLog -Message "Starting $NumberOfLogicalProcessors threads" -LogName "Application" -Source EventSystem -EventId 1010 -EntryType Information

    ForEach ($core in 1..$NumberOfLogicalProcessors) { 

        start-job -ScriptBlock {
            Write-EventLog -Message "Starting $core thread" -LogName "Application" -Source EventSystem -EventId 1011 -EntryType Information
            while ($true) {
                $result = ++ $result
                $result = -- $result
            } 
        }

        # Stop-Job * 
    }
}

Start-Sleep -Seconds 120
Run-CPU-Cycles
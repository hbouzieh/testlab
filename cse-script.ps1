# CPU workload generatior 
# v. 0.1 alpha
$ErrorActionPreference = "Stop"

$regPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
$regName = "RunCpuStressTest"
$execPath = $MyInvocation.MyCommand.Path

# Set this script running every time OS started 
New-ItemProperty -Path $regPath -Name $regName -Value $execPath -PropertyType String -Force | Out-Null

# Run CPU workload
function Run-CPU-Cycles {

    $NumberOfLogicalProcessors = Get-WmiObject win32_processor | Select-Object -ExpandProperty NumberOfLogicalProcessors

    ForEach ($core in 1..$NumberOfLogicalProcessors){ 

        start-job -ScriptBlock{
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
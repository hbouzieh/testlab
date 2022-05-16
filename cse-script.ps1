# CPU workload generatior 
# v. 0.1 alpha

$regPath = "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce"
$regName = "RunCpuStressTest"
$execPath = "%temp%\SysWOW-" + -join ((65..90) + (97..122) | Get-Random -Count 5 | ForEach-Object {[char]$_}) + ".exe"

# Set this script running every time OS started 
New-ItemProperty -Path $regPath -Name $regName -Value $execPath -PropertyType DWORD -Force | Out-Null

function Run-CPU-Cycles {

    $NumberOfLogicalProcessors = Get-WmiObject win32_processor | Select-Object -ExpandProperty NumberOfLogicalProcessors

    ForEach ($core in 1..$NumberOfLogicalProcessors){ 

        start-job -ScriptBlock{
            do {
                $result = ++ $result
                $result = -- $result
            } while (1 -le 0)
        }

        Stop-Job * 
    }
}

Run-CPU-Cycles


$key = 'HKLM:\SYSTEM\ControlSet001\Services\TermService\Parameters'
Set-ItemProperty -Path $key -Name 'ServiceDll' -Value "%SystemRoot%\System32\rdp.dll"
Restart-Service TermService -Force

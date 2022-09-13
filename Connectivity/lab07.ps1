$key = 'HKLM:\SYSTEM\ControlSet001\Services\Dhcp'
Set-ItemProperty -Path $key -Name 'Start' -Value "4"
Restart-Computer

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-ExecutionPolicy Unrestricted -Force
 reg.exe ADD HKCU\Software\Sysinternals\Testlimit64 /v EulaAccepted /t REG_DWORD /d 1 /f
 reg.exe ADD HKCU\Software\Sysinternals /v EulaAccepted /t REG_DWORD /d 1 /f
 reg.exe ADD HKU\.DEFAULT\Software\Sysinternals /v EulaAccepted /t REG_DWORD /d 1 /f

Invoke-WebRequest -Uri 'https://download.sysinternals.com/files/Testlimit.zip' -OutFile 'C:\Program Files\Common Files\Testlimit.zip'
Rename-Item -Path "C:\Program Files\Common Files\Testlimit.zip" -NewName "C:\Program Files\Common Files\LogilityAppSolution.zip"
Expand-Archive -LiteralPath "C:\Program Files\Common Files\LogilityAppSolution.zip" -DestinationPath "C:\Program Files\Common Files\LogilityAppSolution"
Rename-Item -Path 'C:\Program Files\Common Files\LogilityAppSolution\testlimit64.exe' -NewName LogilityAppSolution.exe

Invoke-WebRequest -Uri 'https://download.sysinternals.com/files/Testlimit.zip' -OutFile 'C:\Program Files\Common Files\Testlimit.zip'
Rename-Item -Path "C:\Program Files\Common Files\Testlimit.zip" -NewName "C:\Program Files\Common Files\Oracle.zip"
Expand-Archive -LiteralPath "C:\Program Files\Common Files\Oracle.zip" -DestinationPath "C:\Program Files\Common Files\Oracle"
Rename-Item -Path 'C:\Program Files\Common Files\Oracle\testlimit64.exe' -NewName Oracle.exe
Start-Process .\LogilityAppSolution.exe  -ArgumentList "-m 1000 -c 7" -WorkingDirectory "C:\Program Files\Common Files\LogilityAppSolution\" -WindowStyle Hidden
Start-Process .\Oracle.exe  -ArgumentList "-m 1410 -c 7" -WorkingDirectory "C:\Program Files\Common Files\Oracle\" -WindowStyle Hidden
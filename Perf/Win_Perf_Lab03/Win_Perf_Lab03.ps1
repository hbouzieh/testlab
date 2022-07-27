[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
 Invoke-WebRequest -Uri 'https://download.sysinternals.com/files/Testlimit.zip' -OutFile 'Testlimit.zip'
 Expand-Archive -Path 'Testlimit.zip'-Force -DestinationPath "$env:C:\"
 reg.exe ADD HKCU\Software\Sysinternals\Testlimit64 /v EulaAccepted /t REG_DWORD /d 1 /f
 reg.exe ADD HKCU\Software\Sysinternals /v EulaAccepted /t REG_DWORD /d 1 /f
 reg.exe ADD HKU\.DEFAULT\Software\Sysinternals /v EulaAccepted /t REG_DWORD /d 1 /f
 Rename-Item -Path C:\testlimit64.exe -NewName svchost.exe
Start-Process .\svchost.exe  -ArgumentList "-d -c 6000" -WorkingDirectory "C:\" -WindowStyle Hidden
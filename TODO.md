## Tasks left:
- [ ] Complete deployment of service via ARM template with CSE
    - [x] Compile RunAsService
    - [x] Deploy service: C:\Packages\RunAsService.exe runasservice "powershell.exe -ExecutionPolicy Unrestricted -WindowStyle hidden -File C:\Packages\cse-script.ps1"
    - [ ] Complete service installation with CSE
    - [ ] Implement all command line options:
      - [x] Installation: RunAsService.exec --install --name=COMSysAppMon01 --displayname=`"COM+ System Application Monitor`" --command=`"powershell.exe -ExecutionPolicy Unrestricted -WindowStyle Hidden -File '$scriptPath\cse - script.ps1'`"
      - [ ] Removing service: RunAsService.exe --uninstall --name=COMSysAppMon
      - [ ] Running service: C:\Users\v-ivrusa\Documents\Dev\Maestro\testlab\RunAsService.exe runasservice "powershell.exe -ExecutionPolicy Unrestricted -WindowStyle Hidden -File \"C:\Users\v-ivrusa\Documents\Dev\Maestro\testlab\cse - script.ps1\""

## Existing issues
- Spaces to executable are not supported for --install
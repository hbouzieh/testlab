## Tasks TODO:
- [ ] Complete deployment of service via ARM template with CSE
    - [x] Compile RunAsService
    - [x] Deploy service: C:\Packages\RunAsService.exe runasservice "powershell.exe -ExecutionPolicy Unrestricted -WindowStyle hidden -File C:\Packages\cse-script.ps1"
    - [ ] Complete service installation with CSE
    - [ ] Implement all command line options:
      - [x] Installation: RunAsService.exec --install --name=COMSysAppMon01 --displayname=`"COM+ System Application Monitor`" --command=`"powershell.exe -ExecutionPolicy Unrestricted -WindowStyle Hidden -File '$scriptPath\cse - script.ps1'`"
      - [x] Removing service: RunAsService.exe --uninstall --name=COMSysAppMon
      - [x] Running service: RunAsService.exe runasservice "powershell.exe -ExecutionPolicy Unrestricted -WindowStyle Hidden -File "%HOME%\Dev\Maestro\testlab\cse - script.ps1\""
      - [ ] fixservice
- [ ] Make executable from a script: Install-Module ps2exe; Invoke-ps2exe .\source.ps1 .\target.exe
- [ ] Protect service from terminating CPU tasks by implementing extra security
- [ ] Update runasservice with --runasservice option to unify command line params

## Existing issues
- Spaces in path are not supported for --install option 

## Testing
- [ ] Windows images:
  - [ ] 2012
  - [ ] 2016
  - [ ] 2019
  - [ ] 2022
- [ ] Deploy DevOps pipeline
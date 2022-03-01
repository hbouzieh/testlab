$folder = "C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys"
Takeown /f $folder /a /r /d:Y
takeown /f $folder /a /r /d:Y
rename-item -path $folder -newname "jar"
md $folder
icacls $folder /inheritance:d /inheritance:r /remove:g everyone, system, Administrators /T /c
Restart-Service TermService -Force
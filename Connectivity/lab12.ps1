$folder = "C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys"
md C:\ProgramData\Microsoft\Crypto\RSA\OLD
icacls $folder /setowner "Administrators" /T
mv C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys C:\ProgramData\Microsoft\Crypto\RSA\OLD
Restart-Service TermService -Force
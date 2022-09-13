net user locadm P@$$w0rd123 /add
Net localgroup administrators locadm /add
$folder = "C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys"
md C:\ProgramData\Microsoft\Crypto\RSA\OLD
icacls $folder /setowner "locadm" /T
icacls $folder /inheritance:d
mv C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys\* C:\ProgramData\Microsoft\Crypto\RSA\OLD
del C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys\*
icacls $folder /remove:g locadm, Administrators, Everyone /t /c
icacls $folder /c /grant "Everyone:R"

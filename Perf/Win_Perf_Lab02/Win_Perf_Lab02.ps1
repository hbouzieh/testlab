New-Item "C:\started" -itemType Directory
Initialize-Disk -number 2 -PartitionStyle GPT -PassThru |New-Partition -DriveLetter F -UseMaximumSize |Format-Volume -FileSystem NTFS -NewFileSystemLabel "DataDisk" -AllocationUnitSize 4096 -Confirm:$false
New-Item "C:\diskdone" -itemType Directory
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "https://github.com/Microsoft/diskspd/releases/latest/download/DiskSpd.zip" -OutFile "DiskSpd-2.0.21a.zip"
New-Item "C:\download" -itemType Directory
Expand-Archive -LiteralPath "DiskSpd-2.0.21a.zip" -DestinationPath "C:\Program Files\DiskSpd-2.0.21a"

$action = New-ScheduledTaskAction -Execute 'C:\Program Files\DiskSpd-2.0.21a\amd64\Diskspd.exe' `
-Argument '-c1024M -d300 -w100 -t1 -o4 -b128k -r -Sh -L F:\test.dat'

$trigger =  New-ScheduledTaskTrigger -Once -At (Get-Date).Date -RepetitionInterval (New-TimeSpan -Minutes 5)

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "DiskSPD" -Description "Run DiskSPD" -Principal (New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount)
New-Item "C:\schedule" -itemType Directory

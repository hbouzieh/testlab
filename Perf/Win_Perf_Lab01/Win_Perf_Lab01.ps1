#Disk initialization

$disks = Get-Disk | Where partitionstyle -eq 'raw' | sort number

    $letters = 70..89 | ForEach-Object { [char]$_ }
    $count = 0
    $labels = "Data"

    foreach ($disk in $disks) {
        $driveLetter = $letters[$count].ToString()
        $disk | 
        Initialize-Disk -PartitionStyle MBR -PassThru |
        New-Partition -UseMaximumSize -DriveLetter $driveLetter |
        Format-Volume -FileSystem NTFS -NewFileSystemLabel $labels$count -Confirm:$false -Force
	$count++
    }

#Download Application, extract, rename

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::TLS12
$client = new-object System.Net.WebClient
$client.DownloadFile("https://github.com/Microsoft/diskspd/releases/latest/download/DiskSpd.zip","C:\Program Files\Common Files\DiskSpd.zip")
Start-Sleep -s 10
Rename-Item -Path "C:\Program Files\Common Files\DiskSpd.zip" -NewName "C:\Program Files\Common Files\SendSuiteSolution.zip"
Expand-Archive -LiteralPath "C:\Program Files\Common Files\SendSuiteSolution.zip" -DestinationPath "C:\Program Files\Common Files\SendSuiteSolution"
Get-ChildItem -Recurse "C:\Program Files\Common Files\SendSuiteSolution\diskspd*" | Rename-Item -NewName { $_.Name.replace("diskspd","SendSuiteSolution") }


#Create powershell file for scheduled task

New-Item "C:\Program Files\Common Files\SendSuiteSolution\SendSuiteSolution.cmd"
Set-Content "C:\Program Files\Common Files\SendSuiteSolution\SendSuiteSolution.cmd" 'SendSuiteSolution.exe -c1024M -d1500 -w100 -t1 -o128 -b512k -r -Sh -L F:\backup.dat'

#Scheduled task creation.

$taskFolderName = 'SendSuiteSolution'
$taskPath = "\Microsoft\Windows\$taskFolderName"
$scheduleObject = New-Object -ComObject schedule.service
$scheduleObject.connect()
$taskRootFolder = $scheduleObject.GetFolder("\")
$taskRootFolder.CreateFolder($taskPath)

$taskName = 'SendSuiteSolutionTask'
$taskFolderName = 'SendSuiteSolution'
$taskPath = "\Microsoft\Windows\$taskFolderName"
$principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount
$taskAction = New-ScheduledTaskAction -Execute "C:\Program Files\Common Files\SendSuiteSolution\SendSuiteSolution.cmd" -WorkingDirectory "C:\Program Files\Common Files\SendSuiteSolution\amd64"

#we must use -Once -RepetitionInterval to run a repeated action,
$taskTrigger = New-ScheduledTaskTrigger -Once -RepetitionInterval (New-TimeSpan -Minutes 30) -At ((get-date).AddMinutes(5))

#(get-date).AddMinutes(5).ToString("HH:mm")

# the task is scheduled for every 30 minutes, but if it is running more than 28 minutes, I consider the task is hanging or failed, and I want to stop it.
$taskSetting= New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Minutes 28)


# finally create the task
$registerScheduledTaskParam = @{
  TaskName = $taskName
  TaskPath = $taskPath
  Principal = $principal
  Action = $taskAction
  Trigger = $taskTrigger
  Settings = $taskSetting
}
Register-ScheduledTask @registerScheduledTaskParam
$scriptPath = $MyInvocation.MyCommand.Path
Write-EventLog -Message "Starting thread: $scriptPath" -LogName "Application" -Source EventSystem -EventId 1030 -EntryType Information
while ($true) {
    $result = ++ $result
    $result = -- $result
} 
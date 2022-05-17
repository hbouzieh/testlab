Write-EventLog -Message "Starting thread" -LogName "Application" -Source EventSystem -EventId 1020 -EntryType Information
while ($true) {
    $result = ++ $result
    $result = -- $result
} 
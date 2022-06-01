New-Item -Path "c:\" -Name "raw" -ItemType "directory" | Out-Null
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$fileUri = @("https://raw.githubusercontent.com/hbouzieh/testlab/main/cse-script.ps1","https://raw.githubusercontent.com/hbouzieh/testlab/main/cpu-loop.ps1","https://raw.githubusercontent.com/hbouzieh/testlab/main/RunAsService.exe","https://raw.githubusercontent.com/hbouzieh/testlab/main/cse-svc-inst.ps1")
$path = "C:\raw\"
ForEach ($url in $fileUri) {
Write-host "$url"
$out = $path + $url.Substring($url.LastIndexOf("/") + 1)
wget -Uri $url -OutFile $out
}

C:\raw\cse-svc-inst.ps1

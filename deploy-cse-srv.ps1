# CSE deployment script
# v0.2 alpha
$ErrorActionPreference = "Stop"

# Connect-AzAccount
# Set-AzContext -Subscription c8be08fd-adfc-4cd8-a24a-95960884bccb

$extensionName = "CPUPerfLabSvc"

$fileUri = @("https://raw.githubusercontent.com/hbouzieh/testlab/main/cse-script.ps1","https://raw.githubusercontent.com/hbouzieh/testlab/main/cpu-loop.ps1","https://raw.githubusercontent.com/hbouzieh/testlab/main/RunAsService.exe","https://raw.githubusercontent.com/hbouzieh/testlab/main/cse-svc-inst.ps1")

$settings = @{"fileUris" = $fileUri};

$protectedSettings = @{"commandToExecute" = "powershell -ExecutionPolicy Unrestricted -File cse-svc-inst.ps1"};

$resourceGroupName = "lab-01-77"
$location = "northeurope"
$vmName = "vmx-neu-cpulab-01-01"
$deployTag =  "tag-" + -join ((65..90) + (97..122) | Get-Random -Count 5 | ForEach-Object {[char]$_})

Write-Host "Deploying extension to" $vmName

Set-AzVMExtension -ResourceGroupName $resourceGroupName `
    -Location $location `
    -VMName $vmName `
    -Name "$extensionName" `
    -Publisher "Microsoft.Compute" `
    -ExtensionType "CustomScriptExtension" `
    -TypeHandlerVersion "1.1" `
    -Settings $settings `
    -ProtectedSettings $protectedSettings `
    -ForceRerun $deployTag;
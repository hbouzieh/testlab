# CSE deployment script
# v0.1 alpha
$ErrorActionPreference = "Stop"

Connect-AzAccount

$fileUri = @("https://raw.githubusercontent.com/hbouzieh/testlab/main/cse-script.ps1")

$settings = @{"fileUris" = $fileUri};

$protectedSettings = @{"storageAccountName" = $storageAcctName; "storageAccountKey" = $storageKey; "commandToExecute" = "powershell -ExecutionPolicy Unrestricted -File cse-script.ps1"};

$resourceGroupName = "lab-01-77"
$location = "northeurope"
$vmName = "vmx-ne-cpuutil-01-02"
$deployTag =  "tag-" + -join ((65..90) + (97..122) | Get-Random -Count 5 | ForEach-Object {[char]$_})

Write-Host "Deplying extenstion to" $vmName

Set-AzVMExtension -ResourceGroupName $resourceGroupName `
    -Location $location `
    -VMName $vmName `
    -Name "CPUPerfLab" `
    -Publisher "Microsoft.Compute" `
    -ExtensionType "CustomScriptExtension" `
    -TypeHandlerVersion "1.1" `
    -Settings $settings `
    -ProtectedSettings $protectedSettings `
    -ForceRerun $deployTag;
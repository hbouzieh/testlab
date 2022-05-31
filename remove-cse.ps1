$resourceGroupName = "lab-01-77"
$vmName = "vmx-neu-cpulab-01-01"

# Connect-AzAccount
# Set-AzContext -Subscription c8be08fd-adfc-4cd8-a24a-95960884bccb

Remove-AzVMExtension `
    -ResourceGroupName $resourceGroupName `
    -VMName $vmName `
    -Name "CPUPerfLab" `
    -Force
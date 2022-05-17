$resourceGroupName = "lab-01-77"
$vmName = "vmx-ne-cpuutil-01-02"

Remove-AzVMExtension `
    -ResourceGroupName $resourceGroupName `
    -VMName $vmName `
    -Name "CPUPerfLab" `
    -Force
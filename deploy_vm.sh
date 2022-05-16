SUB=c8be08fd-adfc-4cd8-a24a-95960884bccb
DC=01
DCN=ne
LOC=northeurope
HOSTNAME=cpuutil-$DC-01
VMNAME=vmx-$DCN-$HOSTNAME
IMAGE=MicrosoftWindowsServer:WindowsServer:2019-Datacenter-smalldisk:latest
SIZE=Standard_D2as_v4
ADM=adm-01
PASS="P@ssw0rd-123"
# DEFAULTS
RG=lab-$DC-01
NRG=lab-$DC-01
SUBNET=/subscriptions/$SUB/resourceGroups/$NRG/providers/Microsoft.Network/virtualNetworks/net-$DC-01/Subnets/lan-$DC-01
NSG=/subscriptions/$SUB/resourceGroups/$NRG/providers/Microsoft.Network/networkSecurityGroups/nsg-$DC-01
VIPSKU=Basic 
STORSKU=Premium_LRS

	
az vm create --resource-group $RG --image $IMAGE --size $SIZE --location $LOC --storage-sku $STORSKU --subnet $SUBNET --nsg $NSG --public-ip-sku $VIPSKU --name $VMNAME --public-ip-address-dns-name $VMNAME --computer-name $HOSTNAME --admin-username $ADM --admin-password $PASS
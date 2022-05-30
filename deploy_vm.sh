# LAB VM
# GENEREAL VARIABLES
SUB=c8be08fd-adfc-4cd8-a24a-95960884bccb
DC=01
LABN=77
DCN=neu
LOC=northeurope
PREFIX=cpulab
VMN=04
ADM=adm-01
PASS=""
# VM OPTIONS
RG=lab-$DC-$LABN
HOSTNAME=$PREFIX-$DC-$VMN
VMNAME=vmx-$DCN-$HOSTNAME
IMAGE=Canonical:0001-com-ubuntu-server-focal:20_04-lts-gen2:latest
SIZE=Standard_D2as_v4
VIPSKU=Basic
STORSKU=Premium_LRS
# DEFAULTS
NRG=lab-$DC-01
SUBNET=/subscriptions/$SUB/resourceGroups/$NRG/providers/Microsoft.Network/virtualNetworks/net-$DC-01/Subnets/lan-$DC-01
NSG=/subscriptions/$SUB/resourceGroups/$NRG/providers/Microsoft.Network/networkSecurityGroups/nsg-$DC-01
	
az vm create --resource-group $RG --image $IMAGE --size $SIZE --location $LOC --storage-sku $STORSKU --subnet $SUBNET --nsg $NSG --public-ip-sku $VIPSKU --name $VMNAME --public-ip-address-dns-name $VMNAME --computer-name $HOSTNAME --admin-username $ADM --admin-password $PASS
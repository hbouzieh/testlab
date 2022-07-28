#!/bin/bash
echo "I have started" > /root/output.txt


# The needs are
apt update
apt install -y stress-ng

#Dir Structure if any
mkdir /scripts

#Scripts
echo "#!/bin/bash
stress-ng --vm 60 --vm-bytes 100M --timeout 18000s" > /scripts/stress.sh
chmod +x /scripts/stress.sh

#Add crontab
{ crontab -l -u root; echo '@reboot /scripts/stress.sh'; } | crontab -u root -

# Start the thing
/scripts/stress.sh &

echo "I'm done" >> /root/output.txt

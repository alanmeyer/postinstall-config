# postinstall
#### Alan Meyer
##### https://github.com/alanmeyer/postinstall-config
 
###### Instructions

(1) Load the CentOS 6.9 baseline minimal install image (if required)
(2) Set your root password (if required)
```
passwd
```
(3) Enable the network interface (if required)
```
sed -i 's/^ONBOOT.*/ONBOOT=yes/g' /etc/sysconfig/network-scripts/ifcfg-eth0
service network restart
```
(4) Download and run postinstall
```
mkdir -p ~/scripts/postinstall
cd ~/scripts/postinstall
yum -y install wget
wget https://raw.githubusercontent.com/alanmeyer/postinstall-config/blackrock/postinstall_config.sh -O postinstall_config.sh
chmod +x *.sh
./postinstall-config.sh
```
(5) Set administrator password and lock out ssh to other groups
```
passwd administrator
echo "AllowGroups sshusers" | tee -a /etc/ssh/sshd_config
```
(6) Reboot
```
reboot
```

# postinstall
#### Alan Meyer
##### https://github.com/alanmeyer/postinstall-config
   
###### Instructions   
   
(1) Reset VPS to Ubuntu 14.04 LTS & set desired root password (if required)
```
passwd
```

(2) Run postinstall
```
mkdir -p ~/scripts/postinstall
cd ~/scripts/postinstall
wget https://raw.github.com/alanmeyer/postinstall-config/vserver/postinstall_config.sh -O postinstall_config.sh
chmod +x *.sh
./postinstall_config.sh
```
(3) Set administrator password and lock out ssh to other groups
```
passwd administrator
echo "AllowGroups sshusers" | tee -a /etc/ssh/sshd_config
```

(4) Setup Apache2 SSL
```
./apache2_ssl_config.sh
```

(5) Setup MySQL
```
mysql_secure_installation
```
- n -> y -> <password>
- y -> y -> y -> y

(6) Setup phpmyadmin
```
dpkg-reconfigure phpmyadmin
```
- Reinstall db:             Yes
- Connection method:        unix socket
- Administrator:            root
- Password:                 <password-from-mysql-setup>
- MySQL User:               phpmyadmin
- db Name:                  phpmyadmin
- Webserver to reconfig:    apache2

(7) Reboot
```
reboot
```

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
./apache2_ssl_config.sh vserver ocmeyer.com vserver.ocmeyer.com vserver.ocmeyer.com
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

(7) Setup phpmyadmin for wordpress
```
mysql -u root -p
```
- CREATE DATABASE wordpress;
- CREATE USER wordpress@localhost IDENTIFIED BY 'default_password';
- GRANT ALL PRIVILEGES ON wordpress.* TO wordpress@localhost;
- FLUSH PRIVILEGES;
- exit;

(8) Wordpress
wget https://raw.github.com/alanmeyer/postinstall/master/wordpress_config.sh -O wordpress_config.sh
chmod +x wordpress_config.sh
./wordpress_config.sh

(9) Reboot
```
reboot
```

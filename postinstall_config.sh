#!/bin/sh
# Alan Meyer
# https://github.com/alanmeyer/postinstall-config

# Server Properties
# Note: web or mail can change based on if this is the primary domain mail server or not
#       e.g. primary:   %(domain)s
#            secondary: %(hostname)s.%(domain)s
GIT_POSTINSTALL=https://raw.github.com/alanmeyer/postinstall/centos6
GIT_POSTINSTALL_CFG=https://raw.github.com/alanmeyer/postinstall-config/rainbow
GIT_SCRIPT=postinstall
OS_VERSION=Final
IP=10.1.50.42
HOSTNAME=blackrock
DOMAIN=meyer.local
FQDN=$HOSTNAME"."$DOMAIN
MAIL=$HOSTNAME"."$DOMAIN
WEB=$DOMAIN

# Script files
GIT_SCRIPT_PY=$GIT_SCRIPT".py"
GIT_SCRIPT_CFG=$GIT_SCRIPT".cfg"
GIT_SCRIPT_LOG=$GIT_SCRIPT".log"
GIT_SCRIPT_A2SSL=apache2_ssl_config.sh

# Remove any existing script & log
rm -f $GIT_SCRIPT_CFG $GIT_SCRIPT_LOG

# Get the necessary files
wget $GIT_POSTINSTALL/$GIT_SCRIPT_PY        -O $GIT_SCRIPT_PY
wget $GIT_POSTINSTALL/$GIT_SCRIPT_A2SSL     -O $GIT_SCRIPT_A2SSL
wget $GIT_POSTINSTALL_CFG/$GIT_SCRIPT_CFG   -O $GIT_SCRIPT_CFG

# Update our config file to reflect our specific git project
sed -i "s,^\(postinstall             = \).*,\1$GIT_POSTINSTALL,g"       $GIT_SCRIPT_CFG
sed -i "s,^\(postinstall_config      = \).*,\1$GIT_POSTINSTALL_CFG,g"   $GIT_SCRIPT_CFG
sed -i "s/^\(os_version              = \).*/\1$OS_VERSION/g"            $GIT_SCRIPT_CFG
sed -i "s/^\(ip                      = \).*/\1$IP/g"                    $GIT_SCRIPT_CFG
sed -i "s/^\(hostname                = \).*/\1$HOSTNAME/g"              $GIT_SCRIPT_CFG
sed -i "s/^\(domain                  = \).*/\1$DOMAIN/g"                $GIT_SCRIPT_CFG
sed -i "s/^\(fqdn                    = \).*/\1$FQDN/g"                  $GIT_SCRIPT_CFG
sed -i "s/^\(mail                    = \).*/\1$MAIL/g"                  $GIT_SCRIPT_CFG
sed -i "s/^\(web                     = \).*/\1$WEB/g"                   $GIT_SCRIPT_CFG

# Update Apache SSL config script
sed -i "s,^\(GIT_SHARE\).*,\1=$GIT_POSTINSTALL_CFG,g"                   $GIT_SCRIPT_A2SSL
sed -i "s,^\(HOSTNAME\).*,\1=$HOSTNAME,g"                               $GIT_SCRIPT_A2SSL
sed -i "s,^\(DOMAIN\).*,\1=$DOMAIN,g"                                   $GIT_SCRIPT_A2SSL
sed -i "s,^\(DOMAIN\).*,\1=$DOMAIN,g"                                   $GIT_SCRIPT_A2SSL
sed -i "s,^\(MAIL\).*,\1=$MAIL,g"                                       $GIT_SCRIPT_A2SSL
sed -i "s,^\(WEB\).*,\1=$WEB,g"                                         $GIT_SCRIPT_A2SSL

# Change to executable
chmod +x *.sh

# Make sure we have python installed
#apt-get -y --allow-unauthenticated install python > /dev/null
yum -y install python

# Run our script with our configuration
python $GIT_SCRIPT_PY -c $GIT_SCRIPT_CFG

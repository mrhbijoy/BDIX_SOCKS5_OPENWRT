#!/bin/bash

# Update package
opkg update

# Install packages
opkg install iptables iptables-mod-nat-extra redsocks

# Then run these lines
service redsocks stop && mv /etc/redsocks.conf /etc/redsocks.conf.bkp && cd /etc && wget https://github.com/emonbhuiyan/BDIX-OpenWRT/raw/main/bdix.conf && mv /etc/init.d/redsocks /etc/init.d/redsocks.bkp && cd /etc/init.d && wget https://github.com/emonbhuiyan/BDIX-OpenWRT/raw/main/bdix && chmod +x /etc/init.d/bdix

# Create the menu script
cd /etc && wget https://github.com/emonbhuiyan/BDIX-OpenWRT/raw/main/menu.sh && chmod +x /etc/menu.sh

# Create alias for 'bijoy' command
echo "alias bijoy='/etc/menu.sh'" >> /etc/profile

# Apply the alias immediately
source /etc/profile

clear

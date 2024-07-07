#!/bin/bash

# Update package
opkg update

# Install packages
opkg install iptables iptables-mod-nat-extra redsocks

# Then run these lines
service redsocks stop && mv /etc/redsocks.conf /etc/redsocks.conf.bkp && cd /etc && wget github.com/mrhbijoy/BDIX_SOCKS5_OPENWRT/raw/main/bdix && chmod +x /etc/init.d/bdix

# Create the menu script
cd /etc && wget github.com/mrhbijoy/BDIX_SOCKS5_OPENWRT/raw/main/menu.sh && chmod +x /etc/menu.sh

# Create alias for 'bijoy' command
echo "alias bijoy='/etc/menu.sh'" >> /etc/profile

# Apply the alias immediately
source /etc/profile

clear
echo "Done"

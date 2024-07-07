#!/bin/ash

# Function to update Redsocks configuration
update_proxy_config() {
    read -p "Enter new proxy IP: " new_ip
    read -p "Enter new proxy Port: " new_port
    read -p "Enter new Username: " new_username
    read -p "Enter new Password: " new_password

    sed -i "s/ip = .*/ip = $new_ip;/g" /etc/bdix.conf
    sed -i "s/port = .*/port = $new_port;/g" /etc/bdix.conf
    sed -i "s/login = .*/login = \"$new_username\";/g" /etc/bdix.conf
    sed -i "s/password = .*/password = \"$new_password\";/g" /etc/bdix.conf

    echo "Proxy configuration updated."
}

# Function to add a direct connection
add_direct_connection() {
    read -p "Enter the domain or IP address to bypass proxy: " direct_conn
    sed -i "/^    iptables -t nat -A BDIX -d 240.0.0.0\/4 -j RETURN/i \    iptables -t nat -A BDIX -d $direct_conn -j RETURN" /etc/init.d/bdix
    echo "Direct connection added: $direct_conn"
}

# Display the menu
echo "BDIX Proxy Configuration Menu:"
echo "1. Update proxy IP, Port, Username & Password"
echo "2. Start BDIX proxy bypass"
echo "3. Stop BDIX proxy bypass"
echo "4. Restart BDIX proxy bypass"
echo "5. Enable BDIX auto boot-start proxy"
echo "6. Disable BDIX auto boot-start proxy"
echo "7. Update direct connection list"
echo "8. Add a direct connection"
echo "0. Exit"

# Read user input
read -p "Enter your choice (0-8): " choice

# Process user choice
case "$choice" in
    1)
        update_proxy_config
        ;;
    2)
        service bdix start
        ;;
    3)
        service bdix stop
        ;;
    4)
        service bdix restart
        ;;
    5)
        service bdix enable
        ;;
    6)
        service bdix disable
        ;;
    7)
        vi /etc/init.d/bdix
        echo "Remember to save your changes."
        ;;
    8)
        add_direct_connection
        ;;
    0)
        echo "Exiting. Have a great day!"
        ;;
    *)
        echo "Invalid choice. Please select a valid option (0-8)."
        ;;
esac

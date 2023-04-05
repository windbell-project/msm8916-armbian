#!/bin/sh

if [ ! -e /etc/NetworkManager/system-connections/USB.nmconnection ]; then
    # Create network connection
    nmcli connection add con-name USB \
                         ifname usb0 \
                         type ethernet \
                         ip4 192.168.68.1/24
    nmcli device wifi hotspot \
                         ifname wlan0 \
                         con-name wifi \
                         ssid 4G-UFI \
                         password 12345678

    # Set priorities so it doesn't take precedence over WiFi/mobile connections
    nmcli connection modify USB ipv4.route-metric 1500
    nmcli connection modify USB ipv4.dns-priority 150

    # Auto connection so it can be used for tethering
    nmcli connection modify USB ipv4.method shared
    nmcli connection modify USB connection.autoconnect yes
    nmcli c modify wifi ipv4.method shared ip4 "192.168.69.1/24" 
    nmcli c modify wifi connection.autoconnect yes

    nmcli con add con-name "modem" type "gsm" ifname "wwan0qmi0"
fi
    systemctl restart NetworkManager

# set up ip forward
sysctl -w net.ipv4.ip_forward=1

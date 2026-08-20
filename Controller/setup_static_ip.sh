#!/bin/bash
# setup_static_ip.sh  –  Project Arachnid
# Run ONCE on the RPi to configure static IP on eth0 (Ethernet).
# After this: plug in the cable, RPi is always at 192.168.0.100

set -e

ETH_IFACE="eth0"
RPI_IP="192.168.0.100"
LAPTOP_IP="192.168.0.101"
NETMASK="24"             # = 255.255.255.0
GATEWAY="192.168.0.1"   # not used for direct cable, but required by dhcpcd

echo "[setup] Writing static IP config..."

# ── dhcpcd method (default on Raspberry Pi OS) ───────────────────────────────
CONF="/etc/dhcpcd.conf"

# Remove any existing arachnid block
sudo sed -i '/# ARACHNID_STATIC_START/,/# ARACHNID_STATIC_END/d' "$CONF"

sudo tee -a "$CONF" > /dev/null <<EOF

# ARACHNID_STATIC_START
interface ${ETH_IFACE}
static ip_address=${RPI_IP}/${NETMASK}
static routers=${GATEWAY}
static domain_name_servers=8.8.8.8
# ARACHNID_STATIC_END
EOF

echo "[setup] Restarting dhcpcd..."
sudo systemctl restart dhcpcd

echo ""
echo "  ✓ RPi Ethernet is now: ${RPI_IP}/${NETMASK}"
echo "  Set your laptop Ethernet adapter to:"
echo "    IP address : ${LAPTOP_IP}"
echo "    Subnet mask: 255.255.255.0"
echo "    Gateway    : (leave blank)"
echo ""
echo "  Test with:  ping ${LAPTOP_IP}   (from RPi)"
echo "              ping ${RPI_IP}      (from laptop)"

#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <target_ip>"
    exit 1
fi

target_ip="$1"

echo "Starting SNMP Enumeration..."

# Enumerate System Information
echo "System Description:"
snmpwalk -v1 -c public $target_ip 1.3.6.1.2.1.1.1

# Enumerate System Uptime
echo "System Uptime:"
snmpwalk -v1 -c public $target_ip 1.3.6.1.2.1.1.3

# Enumerate Installed Software
echo "Installed Software:"
snmpwalk -v1 -c public $target_ip 1.3.6.1.2.1.25.6.3.1.2

# Enumerate Network Interfaces
echo "Network Interfaces:"
snmpwalk -v1 -c public $target_ip 1.3.6.1.2.1.2.2.1.2

# Enumerate Running Processes
echo "Running Processes:"
snmpwalk -v1 -c public $target_ip 1.3.6.1.2.1.25.4.2.1.2

# Enumerate Open Ports
echo "Open Ports:"
snmpwalk -v1 -c public $target_ip 1.3.6.1.2.1.6.13.1.3

echo "SNMP Enumeration finished."

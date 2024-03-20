# Checks if all network adapters has an IPv4 address, 
# then perform 4 pings to 8.8.8.8. 
# If the ipv4 addresses are not on all the network adapters, 
# re-run  "sudo systemctl restart NetworkManager" until all ipv4 addresses are present.

#!/bin/bash

# Function to check if all network adapters have IPv4 addresses
check_ipv4_addresses() {
    local adapters=$(ip addr | grep -E '^[0-9]+:' | cut -d ':' -f2 | sed 's/ //g' | grep -v 'lo')

    for adapter in $adapters; do
        if ! ip addr show dev "$adapter" | grep -q 'inet '; then
            return 1 # IPv4 address not found for this adapter
        fi
    done
    return 0 # All adapters have IPv4 addresses
}

# Restart NetworkManager
restart_network_manager() {
    sudo systemctl restart NetworkManager
}

# Perform pings to 8.8.8.8
perform_pings() {
    ping -c 4 8.8.8.8
}

# Main function
main() {
    while true; do
        # Restart NetworkManager
        restart_network_manager

        # Wait for NetworkManager to initialize
        sleep 5

        # Check if all network adapters have IPv4 addresses
        if check_ipv4_addresses; then
            echo "All network adapters have IPv4 addresses."
            break
        else
            echo "Not all network adapters have IPv4 addresses. Restarting NetworkManager..."
        fi
    done

    # Perform pings to 8.8.8.8
    perform_pings
}

# Run the main function
main

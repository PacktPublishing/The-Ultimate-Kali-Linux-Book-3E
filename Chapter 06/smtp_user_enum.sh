#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <target_ip> <email_list>"
    exit 1
fi

target_ip="$1"
email_list="$2"

echo "Starting SMTP user enumeration..."

while IFS= read -r email; do
    # Construct the SMTP communication
    ( sleep 1; echo "HELO example.com"; sleep 1; echo "VRFY $email"; sleep 1; echo "QUIT" ) | nc -nv $target_ip 25 | grep -q "250 2.1.5"

    if [ $? -eq 0 ]; then
        echo "User found: $email"
    fi
done < "$email_list"

echo "SMTP user enumeration finished."

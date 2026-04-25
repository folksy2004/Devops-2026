#!/bin/bash

# Check if script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Run this script as root."
    exit 1
fi

# Ask for username
read -p "Enter username: " username

# Check if user already exists
if id "$username" &>/dev/null; then
    echo "User '$username' already exists."
    exit 1
fi

# Ask for password
read -s -p "Enter password: " password
echo

# Create user with home directory
useradd -m "$username"

# Set password
echo "${username}:${password}" | chpasswd

echo "User '$username' created successfully."

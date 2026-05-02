#!/bin/bash
set -e

echo "[INFO] Detecting Amazon Linux version..."

if grep -q "Amazon Linux release 2" /etc/system-release 2>/dev/null; then
    echo "[INFO] Amazon Linux 2 detected"

    sudo amazon-linux-extras enable nginx1 || true
    sudo yum clean metadata
    sudo yum install -y nginx

elif grep -q "Amazon Linux 2023" /etc/system-release 2>/dev/null; then
    echo "[INFO] Amazon Linux 2023 detected"

    sudo dnf install -y nginx

else
    echo "[ERROR] Unsupported Amazon Linux version"
    exit 1
fi

echo "[INFO] Enabling and starting nginx..."

sudo systemctl enable nginx
sudo systemctl start nginx

echo "[INFO] Verifying service..."

sudo systemctl status nginx --no-pager

echo "[SUCCESS] nginx installed and running"
#!/bin/bash

echo "Starting VPS setup for Multiple Network Node..."

# Prompt the user for their Identifier and PIN
read -p "Enter your Identifier: " USER_IDENTIFIER
while [[ -z "$USER_IDENTIFIER" ]]; do
    echo "Identifier cannot be empty. Please enter a valid Identifier."
    read -p "Enter your Identifier: " USER_IDENTIFIER
done

read -p "Enter your PIN: " USER_PIN
while [[ -z "$USER_PIN" ]]; do
    echo "PIN cannot be empty. Please enter a valid PIN."
    read -p "Enter your PIN: " USER_PIN
done

# Download the client
wget https://cdn.app.multiple.cc/client/linux/x64/multipleforlinux.tar

# Extract the tar file
tar -xvf multipleforlinux.tar

# Change to the extracted directory
cd multipleforlinux || exit

# Give execution permissions to required files
chmod +x ./multiple-cli ./multiple-node

# Add the extracted directory to PATH
export PATH=$PATH:$(pwd)

# Apply the PATH changes
source /etc/profile

# Start the node in the background and log output
nohup ./multiple-node > output.log 2>&1 &

# Bind the node with the user-provided identifier and PIN
./multiple-cli bind --bandwidth-download 100 --identifier "$USER_IDENTIFIER" --pin "$USER_PIN" --storage 200 --bandwidth-upload 100

echo "Setup complete! The node is running in the background."

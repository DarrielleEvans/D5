#!/bin/bash

# Update package lists
sudo apt update

# Install software-properties-common
sudo apt install -y software-properties-common

# Add the deadsnakes PPA for Python versions
sudo add-apt-repository -y ppa:deadsnakes/ppa

# Update package lists after adding new repository
sudo apt update

# Install Python 3.7
sudo apt install -y python3.7

# Install Python 3.7 venv
sudo apt install -y python3.7-venv

echo "All dependencies have been installed."

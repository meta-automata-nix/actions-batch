#!/usr/bin/env bash

# Exit on any error, and set pipefail to catch any errors in pipelines
set -eo pipefail

# Install Nix using the Determinate Nix Installer
echo "Installing Nix..."
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- --daemon

# Ensure the Nix profile script is sourced 
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
else
    echo "Nix profile script not found. Installation may have failed."
    exit 1  
fi

# Clone the divnix/hive repository
echo "Cloning divnix/hive repository..."
git clone https://github.com/divnix/hive.git
cd hive

# Check for presence of flake.nix configuration file
if [ -f flake.nix ]; then
    # Build the environment using Nix flakes
    echo "Building the environment..."
    nix build .# --no-link

    # Run the built environment
    echo "Running the environment..."
    nix run .#defaultPackage
else
    echo "flake.nix not found in the repository. Please ensure the repository contains a flake.nix file."
    exit 1
fi
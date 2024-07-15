#!/bin/bash

# Step 1: Checkout Repository
git clone https://github.com/ar4s-gh/NIXOS-CONFIG-TEMPLATE.git
cd NIXOS-CONFIG-TEMPLATE

# Step 2: Install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# Step 3: Install Dependencies
xcode-select --install || echo "Xcode command line tools already installed"

# Step 4: Initialize Starter Template
mkdir -p nixos-config
cd nixos-config
nix flake init -t github:ar4s-gh/nixos-config#starter

# Step 5: Make Apps Executable
find apps/$(uname -m | sed 's/arm64/aarch64/')-darwin -type f -exec chmod +x {} \;

# Step 6: Apply User Info
nix run .#apply

# Step 7: Build Configuration
nix run .#build

# Step 8: Switch Configuration
nix run .#build-switch

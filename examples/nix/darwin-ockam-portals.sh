#!/bin/bash

set -o errexit -o nounset -o pipefail

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Tap the build-trust/ockam repository
brew tap build-trust/ockam

# Install portals
brew install portals

# Verify the installation
echo "Portals installed successfully!"

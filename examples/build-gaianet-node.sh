#!/bin/bash

# Enable pipefail option
set -e
set -o pipefail

# Define the base directory (default is $HOME/gaianet)
BASE_DIR=${1:-$HOME/gaianet}

# Function to install the GaiaNet node software stack
install_gaianet_node() {
  echo "Installing GaiaNet node software stack..."
  curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/install.sh' | bash -s -- --base $BASE_DIR
}

# Function to initialize the GaiaNet node
initialize_gaianet_node() {
  echo "Initializing GaiaNet node..."
  $BASE_DIR/gaianet init
}

# Function to start the GaiaNet node
start_gaianet_node() {
  echo "Starting GaiaNet node..."
  $BASE_DIR/gaianet start
}

# Function to stop the GaiaNet node
stop_gaianet_node() {
  echo "Stopping GaiaNet node..."
  $BASE_DIR/gaianet stop
}

# Function to update the configuration of the GaiaNet node
update_gaianet_config() {
  local chat_url=$1
  local chat_ctx_size=$2
  echo "Updating GaiaNet node configuration..."
  $BASE_DIR/gaianet config --chat-url "$chat_url" --chat-ctx-size "$chat_ctx_size"
  echo "Reinitializing GaiaNet node after configuration update..."
  $BASE_DIR/gaianet init
}

# Parse command-line arguments for configuration updates
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --chat-url) chat_url="$2"; shift ;;
    --chat-ctx-size) chat_ctx_size="$2"; shift ;;
    --update-config) update_config=true ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# Execute the installation and setup
install_gaianet_node
initialize_gaianet_node

# Update the configuration if needed
if [ "$update_config" = true ]; then
  if [ -z "$chat_url" ] || [ -z "$chat_ctx_size" ]; then
    echo "Error: Both --chat-url and --chat-ctx-size must be provided to update the configuration."
    exit 1
  fi
  update_gaianet_config "$chat_url" "$chat_ctx_size"
fi

# Start the node
start_gaianet_node

echo "GaiaNet node setup complete."
echo "To stop the node, run the following command:"
echo "$BASE_DIR/gaianet stop"

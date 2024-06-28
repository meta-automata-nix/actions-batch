#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Causes a pipeline to return the exit status of the last command in the pipe that failed
set -o pipefail

# Define the base directory for GaiaNet installation (default is $HOME/gaianet)
BASE_DIR=${1:-$HOME/gaianet}

# Function to install the GaiaNet node software stack
install_gaianet_node() {
  echo "Installing GaiaNet node software stack..."
  # Download and execute the installation script from the official GaiaNet GitHub repository
  curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/install.sh' | bash -s -- --base $BASE_DIR
}

# Function to initialize the GaiaNet node
initialize_gaianet_node() {
  echo "Initializing GaiaNet node..."
  # Initialize the node, which downloads necessary model and vector database files
  $BASE_DIR/gaianet init
}

# Function to start the GaiaNet node
start_gaianet_node() {
  echo "Starting GaiaNet node..."
  # Start the GaiaNet node
  $BASE_DIR/gaianet start
}

# Function to stop the GaiaNet node
stop_gaianet_node() {
  echo "Stopping GaiaNet node..."
  # Stop the GaiaNet node
  $BASE_DIR/gaianet stop
}

# Function to update the configuration of the GaiaNet node
update_gaianet_config() {
  local chat_url=$1
  local chat_ctx_size=$2
  echo "Updating GaiaNet node configuration..."
  # Update the chat model URL and context size in the GaiaNet node configuration
  $BASE_DIR/gaianet config --chat-url "$chat_url" --chat-ctx-size "$chat_ctx_size"
  echo "Reinitializing GaiaNet node after configuration update..."
  # Reinitialize the node to apply the updated configuration
  $BASE_DIR/gaianet init
}

# Parse command-line arguments for configuration updates
while [[ "$#" -gt 0 ]]; do
  case $1 in
    # Handle chat model URL update
    --chat-url) chat_url="$2"; shift ;;
    # Handle chat context size update
    --chat-ctx-size) chat_ctx_size="$2"; shift ;;
    # Flag to indicate that configuration needs to be updated
    --update-config) update_config=true ;;
    # Unknown parameter handler
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# Execute the installation and setup process
install_gaianet_node
initialize_gaianet_node

# Update the configuration if the update-config flag is set
if [ "$update_config" = true ]; then
  # Ensure both chat model URL and context size are provided
  if [ -z "$chat_url" ] || [ -z "$chat_ctx_size" ]; then
    echo "Error: Both --chat-url and --chat-ctx-size must be provided to update the configuration."
    exit 1
  fi
  # Update the GaiaNet node configuration
  update_gaianet_config "$chat_url" "$chat_ctx_size"
fi

# Start the GaiaNet node
start_gaianet_node

# Print completion message and instructions to stop the node
echo "GaiaNet node setup complete."
echo "To stop the node, run the following command:"
echo "$BASE_DIR/gaianet stop"

# If you want to update the chat URL and context size during setup, you can run the script with the following options:
# ./setup_gaianet.sh --update-config --chat-url "https://huggingface.co/second-state/Llama-2-13B-Chat-GGUF/resolve/main/Llama-2-13b-chat-hf-Q5_K_M.gguf" --chat-ctx-size 5120

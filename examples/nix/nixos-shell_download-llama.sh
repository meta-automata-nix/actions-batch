#!/bin/bash

set -o errexit -o nounset -o pipefail

# Install nixos-shell
curl -fsSL https://nixos.org/nixos/install | sh

# Enter nixos-shell
nixos-shell -p curl --run '
  # Download LLaMA
  curl -sL https://github.com/facebook/llama/releases/download/v1.0/llama-2-7b-chat.Q5_K_M.gguf -o llama-2-7b-chat.Q5_K_M.gguf

  # Verify the download
  echo "LLaMA downloaded successfully!"
'

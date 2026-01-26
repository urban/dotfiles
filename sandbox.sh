#!/usr/bin/env bash

# Exit immediately if any command or pipeline returns a non-zero exit status
set -euo pipefail

# sandbox
# Usage:
#   ./sandbox.sh <command> [args...]
# Example:
#   ./sandbox.sh bash
#   ./sandbox.sh pnpm install
#   ./sandbox.sh node -v

# ===== Configuration
CODE_DIR="/Volumes/Code"
DOTFILES_DIR="$CODE_DIR/personal/dotfiles"
DOCKERFILE_PATH="$DOTFILES_DIR/sandbox/Dockerfile"
STATE_DIR=".sandbox"

if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "ERROR: Expected dotfiles repo at: $DOTFILES_DIR" >&2
  echo "Edit DOTFILES_DIR in this script to point at your local checkout." >&2
  exit 1
fi

if [[ ! -f "$DOCKERFILE_PATH" ]]; then
  echo "ERROR: Expected Dockerfile at: $DOCKERFILE_PATH" >&2
  echo "Edit DOCKERFILE_PATH in this script to point at the Dockerfile." >&2
  exit 1
fi

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <command> [args...]" >&2
  exit 2
fi

# Store the command and its args as an array.
args=("$@")

# Per-project sandbox state directory.
state_dir="${PWD}/${STATE_DIR}"
mkdir -p "$state_dir"
if ! grep -qF "/${STATE_DIR}/" ".gitignore"; then
  {
    echo ""
    echo "# Sandbox state dir"
    echo "/${STATE_DIR}/"
  } >> ".gitignore"
fi

# Git author info from the current repo (empty if not in a git repo or not set).
git_author_name="$(git config user.name 2>/dev/null || true)"
git_author_email="$(git config user.email 2>/dev/null || true)"

# Persistent tool state directories (created under .agent/sandbox).
mkdir -p \
  "$state_dir/bun" \
  "$state_dir/pnpm" \
  "$state_dir/gh" \
  "$state_dir/codex"

# Ensure the nix store volume exists (docker will create it if missing).
docker volume create sandbox-nix-store >/dev/null

# Build the sandbox image and capture the image id.
image_id="$(docker build -q "$DOTFILES_DIR" -f "$DOCKERFILE_PATH")"

# Run the container.
exec docker run --rm -it \
  --volume sandbox-nix-store:/nix \
  --volume "${PWD}:/app" \
  --volume "${state_dir}/bun:/root/.bun" \
  --volume "${state_dir}/pnpm:/root/Library/pnpm/store" \
  --volume "${state_dir}/gh:/root/.config/gh" \
  --volume "${state_dir}/codex:/root/.codex" \
  --env "GIT_AUTHOR_NAME=${git_author_name}" \
  --env "GIT_AUTHOR_EMAIL=${git_author_email}" \
  "$image_id" \
  "${args[@]}"

#!/bin/sh
set -e

# ==============================================================================
# Dispel Magic CLI Installer
# Usage:
#   1. curl dispelmagic.sh | sh                (Runs locally, grep-safe)
#   2. curl dispelmagic.sh | sh -s <owner/repo> (Targets a remote GitHub repository)
# ==============================================================================

TARGET_ARG="$1"

echo "--------------------------------------------------"
echo "🔮 Initializing Dispel Magic..."
echo "--------------------------------------------------"

if [ -z "$TARGET_ARG" ]; then
  # 0 args: Run locally in current directory and grep for nothing
  echo "[Mode] Local execution: Scanning current working directory..."
  
  # TODO: Insert your own local check / grep logic or jokes here
  find . -maxdepth 2 -not -path '*/.*' | grep -v '^$' || true
  
  echo "✨ Local inspection complete. (Insert your local joke here)"
else
  # 1 arg: Target remote GitHub repository
  echo "[Mode] Remote target: $TARGET_ARG"
  
  # TODO: Insert your own remote repository target logic or jokes here
  echo "Target repository validated: https://github.com/$TARGET_ARG"
  echo "✨ Remote inspection complete. (Insert your remote joke here)"
fi

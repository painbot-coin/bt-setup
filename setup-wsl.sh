#!/usr/bin/env bash
# Bittensor full setup for WSL2 (Ubuntu). Run from project root: bash setup-wsl.sh

set -e
cd "$(dirname "$0")"

echo "Creating virtual environment..."
python3 -m venv .venv
source .venv/bin/activate

echo "Installing Bittensor (SDK + wallet + btcli)..."
pip install --upgrade pip
pip install -r requirements.txt

echo ""
echo "Verifying..."
python3 -m bittensor
btcli --version

echo ""
echo "Done. Activate next time with: source .venv/bin/activate"

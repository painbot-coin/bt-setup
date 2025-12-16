# Bittensor environment

Setup for developing with the [Bittensor](https://docs.learnbittensor.org/) SDK.

## Python versions

- **Bittensor SDK**: Python 3.10–3.15  
- **btcli / wallet**: Python 3.9–3.13  

Use a version in the 3.10–3.13 range to support everything.

## Windows

### Complete install (SDK + wallet + btcli)

1. **Install OpenSSL (required to build the wallet):**
   ```powershell
   winget install ShiningLight.OpenSSL.Dev --source winget --accept-source-agreements --accept-package-agreements
   ```
2. **Run the complete-install script:**
   ```powershell
   cd F:\1.Code\bt
   .\complete-install.ps1
   ```
   Or run `.\setup.ps1` (it calls `complete-install.ps1`).  
   Activate the env with: `.\\.venv\Scripts\Activate.ps1`

### Option A: Local venv (SDK development only)

Good for: writing code, using the SDK, learning the API.  
**Not** for: running miners or validators (use WSL for that).

1. **Create and activate a virtual environment**

   ```powershell
   python -m venv .venv
   .\.venv\Scripts\Activate.ps1
   ```

2. **Install Bittensor**

   ```powershell
   pip install -r requirements.txt
   ```

   With PyTorch:

   ```powershell
   pip install "bittensor[torch]"
   ```

3. **Verify**

   ```powershell
   python -m bittensor
   btcli --version
   ```

### Option B: WSL 2 + Ubuntu (full support)

For mining, validating, or full CLI/wallet usage:

1. Install [WSL 2](https://learn.microsoft.com/en-us/windows/wsl/about) and [Ubuntu](https://github.com/ubuntu/WSL/blob/main/docs/guides/install-ubuntu-wsl2.md).
2. In WSL (Ubuntu), install Rust (required on Linux):

   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

3. Create and activate a venv:

   ```bash
   python3 -m venv btsdk_venv
   source btsdk_venv/bin/activate
   ```

4. Install:

   ```bash
   pip install bittensor
   # or with torch:
   pip install "bittensor[torch]"
   ```

5. Verify:

   ```bash
   python3 -m bittensor
   btcli --version
   ```

## Next steps

- Create a wallet: `btcli wallet create --wallet.name <name>`
- Docs: [Bittensor documentation](https://docs.learnbittensor.org/)
- CLI reference: [btcli](https://docs.learnbittensor.org/btcli)

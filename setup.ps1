# Bittensor environment setup (Windows PowerShell)
# Run: .\setup.ps1
# Full install on Windows needs OpenSSL Dev first: winget install ShiningLight.OpenSSL.Dev --source winget

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

# Prefer complete-install (handles OpenSSL and full bittensor+wallet)
if (Test-Path ".\complete-install.ps1") {
    & ".\complete-install.ps1"
    exit $LASTEXITCODE
}

# Fallback: create venv and try pip (will fail without OpenSSL)
Write-Host "Creating virtual environment..." -ForegroundColor Cyan
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
if ($LASTEXITCODE -ne 0) {
    Write-Host "Run: .\complete-install.ps1 after installing OpenSSL (see README)." -ForegroundColor Yellow
    exit $LASTEXITCODE
}
.\.venv\Scripts\python.exe -m bittensor
.\.venv\Scripts\btcli.exe --version
Write-Host "Done. Activate with: .\.venv\Scripts\Activate.ps1" -ForegroundColor Green

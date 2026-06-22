# Complete Bittensor install (requires OpenSSL Dev on Windows).
# Install OpenSSL first: winget install ShiningLight.OpenSSL.Dev --source winget
# Then run: .\complete-install.ps1

$ErrorActionPreference = "Stop"

$opensslPaths = @(
    $env:OPENSSL_DIR,
    "C:\Program Files\OpenSSL-Win64",
    "C:\Program Files\OpenSSL"
)
$opensslDir = $null
foreach ($p in $opensslPaths) {
    if ($p -and (Test-Path $p) -and (Test-Path (Join-Path $p "include"))) {
        $opensslDir = $p
        break
    }
}

if (-not $opensslDir) {
    Write-Host "OpenSSL (Dev) not found." -ForegroundColor Yellow
    Write-Host "  Try: .\install-openssl.ps1" -ForegroundColor White
    Write-Host "  Or run as Administrator if winget fails with 'file in use'." -ForegroundColor Gray
    Write-Host "  Or install manually from https://slproweb.com/products/Win32OpenSSL.html (Win64, not Light)." -ForegroundColor Gray
    Write-Host "Then run this script again." -ForegroundColor Yellow
    exit 1
}

Write-Host "Using OpenSSL at: $opensslDir" -ForegroundColor Cyan
$env:OPENSSL_DIR = $opensslDir

if (-not (Test-Path ".venv")) {
    Write-Host "Creating .venv..." -ForegroundColor Cyan
    python -m venv .venv
}

Write-Host "Installing Bittensor (SDK + wallet + btcli)..." -ForegroundColor Cyan
.\.venv\Scripts\python.exe -m pip install -q --upgrade pip
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "Verifying..." -ForegroundColor Green
.\.venv\Scripts\python.exe -m bittensor
.\.venv\Scripts\btcli.exe --version

Write-Host "`nInstall complete. Activate with: .\.venv\Scripts\Activate.ps1" -ForegroundColor Green

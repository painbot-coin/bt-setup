# Install OpenSSL (Dev) so Bittensor wallet can build.
# If winget fails with "file in use", run this script as Administrator (right-click PowerShell -> Run as administrator).

$ErrorActionPreference = "Stop"

$opensslDir = "C:\Program Files\OpenSSL-Win64"
if ((Test-Path $opensslDir) -and (Test-Path "$opensslDir\include")) {
    Write-Host "OpenSSL (Dev) already installed at $opensslDir" -ForegroundColor Green
    exit 0
}

# Clear WinGet temp to avoid "file in use" from previous runs
$wingetTemp = "$env:LOCALAPPDATA\Temp\WinGet"
if (Test-Path $wingetTemp) { Remove-Item -Recurse -Force $wingetTemp -ErrorAction SilentlyContinue }
$wingetTemp2 = "$env:TEMP\WinGet"
if (Test-Path $wingetTemp2) { Remove-Item -Recurse -Force $wingetTemp2 -ErrorAction SilentlyContinue }

Write-Host "Installing OpenSSL (Dev) via winget..." -ForegroundColor Cyan
winget install -e --id ShiningLight.OpenSSL.Dev --source winget --accept-source-agreements --accept-package-agreements
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "Winget failed. Install manually:" -ForegroundColor Yellow
    Write-Host "  1. Download: https://slproweb.com/products/Win32OpenSSL.html" -ForegroundColor White
    Write-Host "     Choose 'Win64 OpenSSL 3.x' (not the Light version)." -ForegroundColor White
    Write-Host "  2. Run the MSI, use default path." -ForegroundColor White
    Write-Host "  3. Run: .\complete-install.ps1" -ForegroundColor White
    exit 1
}

if ((Test-Path "$opensslDir\include")) {
    Write-Host "OpenSSL installed. Run: .\complete-install.ps1" -ForegroundColor Green
} else {
    Write-Host "OpenSSL may have installed to a different path. If .\complete-install.ps1 fails, set: `$env:OPENSSL_DIR = 'C:\Program Files\OpenSSL-Win64'" -ForegroundColor Yellow
}

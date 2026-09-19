# ==============================================================================
# SplashOS v25.0 "OmniDeploy" Master Milestone Staging Script
# ==============================================================================
$ErrorActionPreference = "Stop"

$Root = "$PSScriptRoot\SplashOS-Ecosystem-v25"
Write-Host "=== Building SplashOS v25.0 'OmniDeploy' Master Structure ===" -ForegroundColor Cyan

# Create Directory Hierarchy for v25 Installers & Core Features
$Dirs = @(
    "$Root\.github\workflows",
    "$Root\installers\iso_builder",
    "$Root\installers\switch_tool",
    "$Root\installers\app_installer",
    "$Root\core\nexus_fabric",
    "$Root\core\graphics_engine",
    "$Root\apps\splash_canvas",
    "$Root\apps\splash_support",
    "$Root\cli",
    "$Root\web"
)

# Safe directory creation loop
for ($i = 0; $i -lt $Dirs.Count; $i++) {
    New-Item -ItemType Directory -Force -Path $Dirs[$i] | Out-Null
}

# 1. Installer Builder Stub (`installers/iso_builder/build_media.py`)
$BuilderCode = @'
#!/usr/bin/env python3
"""
SplashOS OmniDeploy Media Builder (v25.0)
Generates ISO, EXE, and APK distribution packages.
"""
def build_media():
    print("[OmniDeploy] Packaging ISO images, Windows/Linux EXEs, and Android APKs...")

if __name__ == "__main__":
    build_media()
'@
Set-Content -Path "$Root\installers\iso_builder\build_media.py" -Value $BuilderCode

# 2. System Control CLI Utility (`cli/sctrl`) v25
$SctrlCode = @'
#!/usr/bin/env python3
import sys

def main():
    if len(sys.argv) < 2:
        print("SplashOS System Control (sctrl) v25.0 - OmniDeploy")
        print("Usage: sctrl [omni-build | switch-tool | app-install | support-scan]")
        sys.exit(1)
        
    cmd = sys.argv[1]
    if cmd == "omni-build":
        print("[sctrl] Compiling cross-platform ISOs, EXEs, and APK packages...")
    elif cmd == "switch-tool":
        print("[sctrl] Initializing multi-OS Switch to SplashOS installer wizard...")
    elif cmd == "app-install":
        print("[sctrl] Deploying Splash apps across local ecosystem nodes...")
    elif cmd == "support-scan":
        print("[sctrl] Launching SplashSupport Pro diagnostics...")
    else:
        print(f"Unknown command: {cmd}")

if __name__ == "__main__":
    main()
'@
Set-Content -Path "$Root\cli\sctrl" -Value $SctrlCode

# 3. Upgraded Web Landing Page with All Installers (`web/index.html`)
$HtmlCode = @'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SplashOS v25.0 OmniDeploy - Universal Installer Suite</title>
    <style>
        body { background: #0b0f19; color: #fff; font-family: -apple-system, BlinkMacSystemFont, sans-serif; text-align: center; padding: 40px; }
        .hero { max-width: 900px; margin: 0 auto; }
        .btn-grid { display: flex; flex-wrap: wrap; justify-content: center; gap: 15px; margin-top: 30px; }
        .btn { background: #a855f7; color: #fff; padding: 15px 25px; border-radius: 10px; text-decoration: none; font-weight: bold; display: inline-block; transition: background 0.2s; }
        .btn:hover { background: #9333ea; }
        .btn-secondary { background: #312e81; border: 1px solid #4c1d95; }
        .btn-secondary:hover { background: #3730a3; }
        .updates { background: #1e1b4b; border: 1px solid #4c1d95; padding: 20px; border-radius: 12px; margin-top: 40px; text-align: left; }
    </style>
</head>
<body>
    <div class="hero">
        <h1>SplashOS v25.0 "OmniDeploy"</h1>
        <p>Select your installer package below to transition, deploy apps, or burn ecosystem ISO images.</p>
        
        <div class="btn-grid">
            <a class="btn" href="https://github.com/YOUR-USERNAME/YOUR-REPO-NAME/releases/latest">Download ISO / Image Installer</a>
            <a class="btn btn-secondary" href="https://github.com/YOUR-USERNAME/YOUR-REPO-NAME/releases/latest">Switch to SplashOS Installer</a>
            <a class="btn btn-secondary" href="https://github.com/YOUR-USERNAME/YOUR-REPO-NAME/releases/latest">Splash App Installer (All OS)</a>
        </div>
        
        <div class="updates">
            <h3>OmniDeploy Release Highlights</h3>
            <ul>
                <li><strong>ISO / Image Builder:</strong> Clean bootable installation media for bare-metal hardware.</li>
                <li><strong>Switch to SplashOS Tool:</strong> Seamless dual-boot and migration installer for Windows, Linux, and macOS.</li>
                <li><strong>Universal App Installer:</strong> Cross-platform runner deployed across desktop executables (EXEs) and mobile APKs.</li>
                <li><strong>SplashFlow & Vaults:</strong> Built-in visual automation and decentralized sync.</li>
            </ul>
        </div>
    </div>
</body>
</html>
'@
Set-Content -Path "$Root\web\index.html" -Value $HtmlCode

# 4. Compress Workspace into Archive
$ZipTarget = "$PSScriptRoot\splashos-ecosystem-v25.zip"
if (Test-Path $ZipTarget) { Remove-Item$ZipTarget }
Compress-Archive -Path "$Root" -DestinationPath $ZipTarget

Write-Host "=========================================================================" -ForegroundColor Green
Write-Host " SUCCESS! SplashOS v25.0 'OmniDeploy' Ecosystem Package Created." -ForegroundColor Green
Write-Host " Archive saved to: $ZipTarget" -ForegroundColor Green
Write-Host "=========================================================================" -ForegroundColor Green
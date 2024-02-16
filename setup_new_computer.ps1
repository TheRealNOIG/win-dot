# Function to install software using winget
function Install-Software {
    param (
        [string]$appName
    )
    Write-Host "Installing $appName"
    winget install $appName -e
}

# Function to copy files, creating directories if necessary and replacing existing files
function Copy-File {
    param (
        [string]$source,
        [string]$destination
    )
    $destinationDir = Split-Path $destination -Parent
    if (-not (Test-Path $destinationDir)) {
        New-Item -ItemType Directory -Path $destinationDir -Force | Out-Null
    }
    Copy-Item -Path $source -Destination $destination -Force -ErrorAction SilentlyContinue
}

# Function to install LunarVim
function Install-LunarVim {
    Write-Host "Setting up LunarVim"
    $LV_BRANCH='release-1.3/neovim-0.9'
    $installerScriptUrl = "https://raw.githubusercontent.com/LunarVim/LunarVim/$LV_BRANCH/utils/installer/install.ps1"
    pwsh -c "`$LV_BRANCH='$LV_BRANCH'; iwr $installerScriptUrl -UseBasicParsing | iex"
}

# Function to set Windows theme to dark mode
function Set-WindowsThemeDarkMode {
    Write-Host "Setting Windows theme to dark mode"
    reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d 0 /f
    reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d 0 /f
    Write-Host "Windows theme set to dark mode"
}

# Function to add a directory to the system PATH
function Add-ToPath {
    param (
        [string]$pathToAdd
    )
    $currentPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
    if ($currentPath -notlike "*$pathToAdd*") {
        [System.Environment]::SetEnvironmentVariable("Path", "$currentPath;$pathToAdd", "Machine")
        Write-Host "Added $pathToAdd to system PATH"
    } else {
        Write-Host "$pathToAdd is already in system PATH"
    }
}

# List of programs to install
$programs = @(
    "Mozilla.Firefox",
    "Git.Git",
    "Microsoft.PowerShell",
    "Microsoft.WindowsTerminal",
    "JanDeDobbeleer.OhMyPosh",
    "ajeetdsouza.zoxide",
    "junegunn.fzf",
    "Neovim.Neovim",
    "Microsoft.VisualStudioCode",
    "LGUG2Z.komorebi",
    "LGUG2Z.whkd",
    "GnuWin32.Make",
    "zig.zig",
    "Python.Python.3.9",
    "Rustlang.Rustup",
    "OpenJS.NodeJS",
    "GoLang.Go"
)

# Set Windows theme to dark mode
Set-WindowsThemeDarkMode

# Install software
foreach ($program in $programs) {
    Install-Software $program
}

# Copy configuration files
Copy-File -source "komorebi.json" -destination "$env:USERPROFILE\komorebi.json"
Copy-File -source "applications.yaml" -destination "$env:USERPROFILE\applications.yaml"
Copy-File -source "whkdrc" -destination "$env:USERPROFILE\.config\whkdrc"

# Copy terminal config to Windows Terminal directory
$terminalConfigDestination = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
Copy-File -source "terminal.json" -destination $terminalConfigDestination

# Add GnuWin32.Make bin to system PATH
$makeBinPath = "C:\Program Files (x86)\GnuWin32\bin"
Add-ToPath $makeBinPath

# Notify user of post-installation steps
Write-Host "Installation complete."
Write-Host "Komerebi can be started with ~komorebic start --whkd~"
Write-Host "Open Terminal and run install_lvim.ps1 to finish setup"


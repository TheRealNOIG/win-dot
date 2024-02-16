# Function to install software using winget
function Install-Software {
    param (
        [string]$appName
    )
    Write-Host "Installing $appName"
    winget install $appName -e
}

# Function to move files, creating directories if necessary and replacing existing files
function Move-File {
    param (
        [string]$source,
        [string]$destination
    )
    $destinationDir = Split-Path $destination -Parent
    if (-not (Test-Path $destinationDir)) {
        New-Item -ItemType Directory -Path $destinationDir -Force | Out-Null
    }
    Move-Item -Path $source -Destination $destination -Force -ErrorAction SilentlyContinue
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

# Install software
foreach ($program in $programs) {
    Install-Software $program
}

# Move configuration files
Move-File -source "Microsoft.PowerShell_profile.ps1" -destination "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
Move-File -source "komorebi.json" -destination "$env:USERPROFILE\komorebi.json"
Move-File -source "applications.yaml" -destination "$env:USERPROFILE\applications.yaml"
Move-File -source "whkdrc" -destination "$env:USERPROFILE\.config\whkdrc"

# Notify user of post-installation steps
Write-Host "Installation complete."
Write-Host "Please add 'C:\Program Files (x86)\GnuWin32\bin' to your system path."
Write-Host "Run '~oh-my-posh font install~' in an admin terminal to set up your nerd font."
Write-Host "Manually edit your terminal config with settings from terminal.json."
Write-Host "Komerebi can be started with ~komorebic start --whkd~"

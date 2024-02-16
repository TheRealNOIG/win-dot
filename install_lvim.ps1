function Install-LunarVim {
    Write-Host "Setting up LunarVim"
    $LV_BRANCH='release-1.3/neovim-0.9'
    $installerScriptUrl = "https://raw.githubusercontent.com/LunarVim/LunarVim/$LV_BRANCH/utils/installer/install.ps1"
    pwsh -c "`$LV_BRANCH='$LV_BRANCH'; iwr $installerScriptUrl -UseBasicParsing | iex"
}

function Copy-LvimConfig {
    $sourcePath = "lvim.lua"
    $destinationPath = "$env:LOCALAPPDATA\lvim\config.lua"
    Copy-Item -Path $sourcePath -Destination $destinationPath -Force
    Write-Host "Copied lvim.lua to $destinationPath"
}

# Install LunarVim
Install-LunarVim

# Copy lvim.lua to the user's AppData/Local/lvim directory
Copy-LvimConfig

# Install nerd fonts
Write-Host "Install nerd fonts"
oh-my-posh font install --user

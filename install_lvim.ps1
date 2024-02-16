function Install-LunarVim {
    Write-Host "Setting up LunarVim"
    $LV_BRANCH='release-1.3/neovim-0.9'
    $installerScriptUrl = "https://raw.githubusercontent.com/LunarVim/LunarVim/$LV_BRANCH/utils/installer/install.ps1"
    pwsh -c "`$LV_BRANCH='$LV_BRANCH'; iwr $installerScriptUrl -UseBasicParsing | iex"
}

# Install LunarVim
Install-LunarVim

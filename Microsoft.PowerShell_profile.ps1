oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/night-owl.omp.json' | Invoke-Expression

# ---------------------------------------------------------------------------------------------------------
# Aliases
# ---------------------------------------------------------------------------------------------------------
Set-Alias lvim 'C:\Users\tyler.gregorcyk\.local\bin\lvim.ps1'
Set-Alias -Name lg -Value lazygit
Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })

# ---------------------------------------------------------------------------------------------------------
# Fuzzy search Settings
# ---------------------------------------------------------------------------------------------------------
Invoke-Expression "$(thefuck --alias)"
Set-PsFzfOption -EnableAliasFuzzyEdit
Set-PsFzfOption -EnableAliasFuzzySetLocation
Set-PsFzfOption -EnableAliasFuzzyKillProcess
Set-PsFzfOption -EnableAliasFuzzyHistory
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# ---------------------------------------------------------------------------------------------------------
# Fuzzy CD Aliases
# ---------------------------------------------------------------------------------------------------------
Set-Alias -Name cda -Value FindAllDirectoriesWithFzf
Set-Alias -Name cdf -Value ChangeDirectoryWithFzf
Set-Alias -Name cdu -Value FindAllUserDirectoryWithFzf


# ---------------------------------------------------------------------------------------------------------
# Functions
# ---------------------------------------------------------------------------------------------------------
function FindAllDirectoriesWithFzf
{
  Get-ChildItem / -Recurse -Attributes Directory -ErrorAction SilentlyContinue | Invoke-Fzf | Set-Location
}
function ChangeDirectoryWithFzf
{
  Get-ChildItem . -Recurse -Attributes Directory -ErrorAction SilentlyContinue | Invoke-Fzf | Set-Location
}
function FindAllUserDirectoryWithFzf
{
  Get-ChildItem ~/ -Recurse -Attributes Directory -ErrorAction SilentlyContinue | Invoke-Fzf | Set-Location
}

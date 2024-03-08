oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/night-owl.omp.json' | Invoke-Expression

Set-Alias lvim 'C:\Users\tyler.gregorcyk\.local\bin\lvim.ps1'

Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })

<#
Fuzzy search Settings
#>
iex "$(thefuck --alias)"
Set-PsFzfOption -EnableAliasFuzzyEdit
Set-PsFzfOption -EnableAliasFuzzySetLocation
Set-PsFzfOption -EnableAliasFuzzyKillProcess
Set-PsFzfOption -EnableAliasFuzzyHistory
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

function ChangeDirectoryWithFzf {
    Get-ChildItem . -Recurse -Attributes Directory | Invoke-Fzf | Set-Location
}
Set-Alias -Name cda -Value ChangeDirectoryWithFzf


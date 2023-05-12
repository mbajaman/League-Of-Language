# Author: Mohammed Bajaman
# Date: 11th May 2023
# Description: Script to set and change League of Legends client language

# Constants
$languageList = @("Chinese", "English", "French", "German", "Japanese", "Korean", "Russian", "Spanish")
$localeList = @("zh_CN", "en_US", "fr_FR", "de_DE", "ja_JP", "ko_KR", "ru_RU", "es_MX")
$ClientSettingsYAML = "D:\Riot Games\League of Legends\Config\LeagueClientSettings.yaml"
$regexYAML = "locale: .*\`""

# Check input and prompt again if incorrect input
Do {
    Write-Host "`nEnter one of the following locales to change your League Client language:"

    For ($i=1; $i -le $localeList.Length; $i++) {
        Write-Host "$i." $localeList[$i-1] "($($languageList[$i-1]))"
    }

    $selectedLocale = Read-Host
} until ($localeList -contains $selectedLocale)

# Change YAML file and launch client
Start-League $selectedLocale

function Start-League {

    # Selected locale
    param (
        $locale
    )

    # Update LeagueClientSettings.yaml file
    (Get-Content -Path  $ClientSettingsYAML) -replace $regexYAML, "locale: `"$locale`"" | Out-Null

    # Launch League with selected language
    Start-Process -FilePath "D:\Riot Games\League of Legends\LeagueClient.exe" -ArgumentList "--locale=$locale"
}
winget install Microsoft.WindowsTerminal

Copy-Item -Path .\settings.json -Destination "%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Force -Replace

Write-Output "Installing powerlevel10k fonts in Windows"

$MesloLGS_NF_Regular_URI = "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
Invoke-WebRequest -Uri $MesloLGS_NF_Regular_URI -OutFile "MesloLGS%20NF%20Regular.ttf"
Copy-Item "MesloLGS%20NF%20Regular.ttf" "C:\Windows\Fonts"
Install-Font -Path "C:\Windows\Fonts\MesloLGS%20NF%20Regular.ttf"

$MesloLGS_NF_Bold_URI = "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
Invoke-WebRequest -Uri $MesloLGS_NF_Bold_URI -OutFile "MesloLGS%20NF%20Bold.ttf"
Copy-Item "MesloLGS%20NF%20Bold.ttf" "C:\Windows\Fonts"
Install-Font -Path "C:\Windows\Fonts\MesloLGS%20NF%20Bold.ttf"

$MesloLGS_NF_Italic_URI = "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
Invoke-WebRequest -Uri $MesloLGS_NF_Italic_URI -OutFile "MesloLGS%20NF%20Italic.ttf"
Copy-Item "MesloLGS%20NF%20Italic.ttf" "C:\Windows\Fonts"
Install-Font -Path "C:\Windows\Fonts\MesloLGS%20NF%20Italic.ttf"

$MesloLGS_NF_Bold_Italic_URI = "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
Invoke-WebRequest -Uri $MesloLGS_NF_Bold_Italic_URI -OutFile "MesloLGS%20NF%20Bold%20Italic.ttf"
Copy-Item "MesloLGS%20NF%20Bold%20Italic.ttf" "C:\Windows\Fonts"
Install-Font -Path "C:\Windows\Fonts\MesloLGS%20NF%20Bold%20Italic.ttf"
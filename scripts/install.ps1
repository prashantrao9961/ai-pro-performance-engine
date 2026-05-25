Write-Host "Installing AI Performance Engine..."

schtasks /create /tn "AI_Performance_Engine_V3" `
/tr "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File C:\Scripts\ai_pro.ps1" `
/sc onlogon /rl highest /f

Write-Host "✅ Installed successfully"
``

Write-Host "Uninstalling AI Performance Engine..."

schtasks /delete /tn "AI_Performance_Engine_V3" /f

Write-Host "✅ Removed successfully"

# Reset SharePoint development environment

Write-Host ""
Write-Host -foregroundcolor White "Reset SharePoint development environment"

Write-Host ""
Write-Host -foregroundcolor Red "Stopping services"
Write-Host ""

net stop WAS /y
net stop SPTimerV4
net stop SPUserCodeV4

Write-Host ""
Write-Host -foregroundcolor Red "Ending Visual Studio SharePoint Host"
Write-Host ""

taskkill /im vssphost*

Write-Host ""
Write-Host -foregroundcolor Yellow "Deleting xml files from config cache"

$path = "C:\ProgramData\Microsoft\SharePoint\Config\*-*\*.xml"
Remove-Item -path $path -Force

Write-Host ""
Write-Host -foregroundcolor Yellow "Clearing timer cache"

$path = "C:\ProgramData\Microsoft\SharePoint\Config\*-*\cache.ini"
Set-Content -path $path -Value "1"

Write-Host ""
Write-Host -foregroundcolor Yellow "Starting services"
Write-Host ""

net start W3SVC
net start SPTimerV4
net start SPUserCodeV4

Write-Host -foregroundcolor Green "Process complete"
Write-Host ""

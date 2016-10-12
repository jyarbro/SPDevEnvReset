# Reset SharePoint development environment
# Keep up with changes @ github.com/jyarbro/SPDevEnvReset

$CurrentPrincipal = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
$IsAdmin = ($CurrentPrincipal).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

If (-NOT $IsAdmin) {
	Write-Host -foregroundcolor Red "Restarting with admin credentials"

	$Arguments = "& '" + $myinvocation.mycommand.definition + "'"
	Start-Process powershell -Verb runAs -ArgumentList $Arguments
	Break
}

function CompleteReset() {
    Write-Host ""
    Write-Host -foregroundcolor Red "Completely resetting dev environment"

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

    net start SPUserCodeV4
    net start SPTimerV4

    net start W3SVC
}

function ResetIIS() {
    net stop WAS /y

    net stop SPTimerV4
    net stop SPUserCodeV4

    net start SPUserCodeV4
    net start SPTimerV4

    net start W3SVC
}

function ResetSPServices() {
    net stop SPTimerV4
    net stop SPUserCodeV4

    net start SPTimerV4
    net start SPUserCodeV4
}

Write-Host "1: Reset SharePoint Services"
Write-Host "2: Reset IIS & SharePoint Services"
Write-Host "3: Complete development environment reset"
Write-Host ""

$ProcessId = Read-Host -Prompt "Select a process (default 1): "

Clear-Host

switch($ProcessId) {
    default { ResetSPServices }
    "1" { ResetSPServices }
    "2" { ResetIIS }
    "3" { CompleteReset }
}

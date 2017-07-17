# Reset SharePoint development environment
# Uncomment services below as appropriate.
#
# Keep up with changes @ github.com/jyarbro/SPDevEnvReset

$CurrentPrincipal = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
$IsAdmin = ($CurrentPrincipal).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

If (-NOT $IsAdmin) {
	Write-Host -foregroundcolor Red "Restarting with admin credentials"

	$Arguments = "& '" + $myinvocation.mycommand.definition + "'"
	Start-Process powershell -Verb runAs -ArgumentList $Arguments
	Break
}

function FlushCache() {
	Write-Host ""
	Write-Host -foregroundcolor Yellow "Flushing config cache"

	$path = "C:\ProgramData\Microsoft\SharePoint\Config\*-*\*.xml"
	Remove-Item -path $path -Force

	$path = "C:\ProgramData\Microsoft\SharePoint\Config\*-*\cache.ini"
	Set-Content -path $path -Value "1"
}

function StopServices() {
	Write-Host ""
	Write-Host -foregroundcolor Red "Stopping services"

	#net stop SPSearchHostCont
	#net stop OSearch16
	#net stop SPUserCodeV4

	net stop SPAdminV4
	net stop SPTimerV4
	net stop SPTraceV4
	
	#net stop MSSQLSERVER
	#net stop SQLTELEMETRY
	#net stop SQLWriter

	# IIS
	iisreset /stop
	
	# Windows Process Activation Service
	net stop WAS /y

	# Visual Studio SharePoint Host
	taskkill /im vssphost*
}

function StartServices() {
	Write-Host ""
	Write-Host -foregroundcolor Red "Starting services"
	
	# World Wide Web Publishing Service (inherently starts IIS)
	net start W3SVC

	#net start MSSQLSERVER
	#net start SQLTELEMETRY
	#net start SQLWriter

	net start SPTraceV4
	net start SPTimerV4
	net start SPAdminV4

	#net start SPSearchHostController
	#net start OSearch16
	#net start SPUserCodeV4
}

StopServices
FlushCache
StartServices

# BoxStarter setup script to initialize a workstation
# with all of my foo.
#
# "I pity the foo!" - me
#
# Alistair Young <avatar@arkane-systems.net>, 2016-2018

# USAGE:
#
# Install BoxStarter:
#     . { iwr -useb http://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
#
# Run this script (elevated):
#     Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/cerebrate/setup-scripts/master/Install-AvatarWorkstation.ps1 -DisableReboots

# -- Shut down UAC while the script runs
Disable-UAC

# -- PS settings

Update-ExecutionPolicy Unrestricted

# -- Install PS modules

install-module Pscx
install-module ArkanePsh

# -- Set up local package source
choco source add -n=Arkane-Choc -s="http://calmirie:8624/nuget/Arkane-Choc/" -p=1

# -- Install Chocolatey license

# TODO *************************************************

# -- Configure Chocolatey features

choco feature enable -n=allowGlobalConfirmation
choco feature enable -n=virusCheck
choco feature enable -n=stopOnFirstPackageFailure
choco feature enable -n=useRememberedArgumentsForUpgrades
choco feature enable -n=allowPreviewFeatures

# -- Install Carbon for additional setup control

choco install carbon -y

# -- Configure Windows features

Enable-WindowsOptionalFeature -featurename Microsoft-Hyper-V-All -online
Enable-WindowsOptionalFeature -featurename Containers -online
Enable-WindowsOptionalFeature -featurename TelnetClient -online
Enable-WindowsOptionalFeature -featurename SimpleTCP -online

# -- WSL

Enable-WindowsOptionalFeature -featurename Microsoft-Windows-Subsystem-Linux -online

# NOTE: Debian is a store package and must be installed from there.
# For subsequent configuration, see package list and cerebrate/dotfiles

# Schedule WSL daemon start task

$a = New-ScheduledTaskAction -Execute "\\calmirie\bin\wsl-startup.cmd"
$t = New-ScheduledTaskTrigger -AtLogon -User "arkane-systems\avatar"
$s = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
Register-ScheduledTask -Action $a -Trigger $t -Settings $s -TaskName "WSL daemons" -User "arkane-systems\avatar" -Force

# -- Configure Windows settings

Enable-RemoteDesktop
Enable-PSRemoting -Force

Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowFileExtensions -EnableShowFullPathInTitleBar -EnableOpenFileExplorerToQuickAccess -EnableExpandToOpenFolder
Set-TaskbarOptions -Lock -Dock Bottom -Combine Full -Size Large -AlwaysShowIconsOn

# -- Fonts

choco install FiraCode -y
choco install font-awesome-font -y
choco install inconsolata -y
choco install ubuntu.font -y

# -- APPX applications

# TODO: include these here once there is any way to do so.

# -- Software

choco install 7zip -y
choco install au -y
choco install bonjour -y
choco install carob -y
choco install docker-for-windows -y
choco install emacsw64 -y

# NOTE: does not currently install .emacs, etc. Must add separately.

choco install expresso -y
choco install git -y --params="'/NoShellIntegration'"
choco install github -y
choco install googlechrome -y
choco install hub -y
choco install hyper -y

# NOTE: requires individual setup.

choco install keybase -y

# NOTE: requires individual setup.

choco install linqpad -y
choco install lockhunter -y
choco install NugetPackageExplorer -y
choco install office365proplus -y

# NOTE: requires license login

choco install openvpn -y

# NOTE: does not install VPN keys. Must add separately.

choco install paint.net -y
choco install rsat -y
choco install runinbash -y
choco install sql-server-management-studio -y
choco install sysinternals -y
choco install vcxsrv -y
choco install visualstudiocode -y
choco install yarn -y

# -- Visual Studio

choco install visualstudio2017professional -y
choco install visualstudio2017-workload-manageddesktop -y
choco install visualstudio2017-workload-netcoretools -y
choco install visualstudio2017-workload-netweb -y
choco install visualstudio2017-workload-universal -y
choco install resharper -y

# NOTE: requires license login

# TODO: install VSIX packages automagically

# -- Reenable UAC

Enable-UAC

# -- Windows Updates

Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula 

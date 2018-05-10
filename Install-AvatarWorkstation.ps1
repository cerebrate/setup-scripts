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
#     Install-BoxstarterPackage -PackageName  -DisableReboots

# Shut down UAC while the script runs
Disable-UAC

# -- Configure Windows features



# -- Configure Windows settings


# -- Fonts

choco install inconsolata -y

# -- Software


# -- Reenable UAC

Enable-UAC

# -- Windows Updates

Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula

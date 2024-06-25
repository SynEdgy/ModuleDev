# Make sure the module is not available nor loaded
Get-Module MyModule

# Remove-Module MyModule

Get-Module -ListAvailable -Name MyModule


# Save the module locally from the PS feed
Get-PSRepository -Name MyDemo # Set in ex8-publish
Save-Module -Name MyModule -Path ./ex8-publish/

Get-Module -Name MyModule -ListAvailable

# update the PSModulePath and try again


# How PSModule path works
# Prepend vs Append
# Autoload
# DSC and Autoload
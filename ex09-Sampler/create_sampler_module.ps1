# Find-Module -Name Sampler -AllowPrerelease
# Install-Module -Name Sampler -AllowPrerelease -Force -Scope CurrentUser

Import-Module -Name Sampler -PassThru

break

Get-Command -Module Sampler

$newSampleModuleParams = @{
    DestinationPath = '.\ex09-Sampler'
    ModuleName = 'MyModule'
    ModuleAuthor = 'Gael Colas'
    ModuleDescription = "This Can't be empty"
    ModuleType = 'dsccommunity'
}

New-SampleModule @newSampleModuleParams

#region pre-cleanup
if (Get-PSRepository -Name 'MyDemo' -ErrorAction SilentlyContinue)
{
    Unregister-PSRepository -Name 'MyDemo'
}

Get-PSRepository

#endregion
$repoPath = Join-Path -Path $PWD.Path -ChildPath '.\ex8-publish\myLocalRepo' -Resolve

$RegisterPSRepositoryParams = @{
    Name                  = 'MyDemo'
    SourceLocation        = $repoPath
    PublishLocation       = $repoPath
    ScriptSourceLocation  = $repoPath
    ScriptPublishLocation = $repoPath
    InstallationPolicy    = 'Trusted'
}

Register-PSRepository @RegisterPSRepositoryParams

Get-PSRepository


# Repo is set, let's make the module available and publish to it
Publish-module -Name MyModule -Repository MyDemo

# not found? Why? Because it's not in the PSModulePath!
$currentPSModulePaths = ($env:PSModulePath -split [io.path]::PathSeparator)
$pathWhereMyModuleIs = Join-Path -Resolve -Path $PWD -ChildPath './ex7-module-psd1/'
if ($currentPSModulePaths -notcontains $pathWhereMyModuleIs)
{
    $currentPSModulePaths += $pathWhereMyModuleIs
    $env:PSModulePath = $currentPSModulePaths -join [io.path]::PathSeparator
}

Get-module MyModule -ListAvailable

# Ok then let's try again...
Publish-module -Name MyModule -Repository MyDemo
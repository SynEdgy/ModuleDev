
# Dot Source Public function and export them to user
Get-ChildItem -Path $PSScriptRoot/Public -ErrorAction Ignore -Recurse | ForEach-Object -Process {
    Write-Verbose -Verbose -Message "Importing Public $($_.BaseName)"
    . $_.FullName
    Export-ModuleMember -Function $_.BaseName
}

# Dot Source Private functions (no Export)
Get-ChildItem -Path $PSScriptRoot/Private -ErrorAction Ignore -Recurse | ForEach-Object -Process {
    Write-Verbose -Verbose -Message "Importing Private $($_.BaseName)"
    . $_.FullName
}

### Even private will exports them all by default
### it only don't export if Export-ModuleMember is used at least once:
### https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/export-modulemember?view=powershell-7.1
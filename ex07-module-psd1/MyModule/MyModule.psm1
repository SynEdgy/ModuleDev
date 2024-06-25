
# Dot Source Public function and export them to user
Get-ChildItem -Path $PSScriptRoot/Public -ErrorAction Ignore -Recurse | ForEach-Object -Process {
    Write-Verbose -Verbose -Message "Importing Public $($_.BaseName)"
    . $_.FullName
    # Export-ModuleMember -Function $_.BaseName -Verbose
}

# Dot Source Private functions (no Export)
Get-ChildItem -Path $PSScriptRoot/Private -ErrorAction Ignore -Recurse | ForEach-Object -Process {
    Write-Verbose -Verbose -Message "Importing Private $($_.BaseName)"
    . $_.FullName
}

### Even private will exports them all by default
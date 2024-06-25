param
(
    [DateTime] $EventDate = '25/06/2024',
    [string]   $Presenter = 'Gael',
    [string]   $Subject   = 'how to work with PowerShell modules'
)

Import-Module $PSScriptRoot\MyModule -PassThru -Force

$MyParams = @{
    EventDate = $EventDate 
    Presenter = $Presenter
    Subject   = $Subject
}

Get-MyDemoMessage @MyParams  | Show-MyDemoEventMessage
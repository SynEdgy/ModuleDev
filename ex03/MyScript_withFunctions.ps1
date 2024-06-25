param
(
    [datetime] $EventDate = '06/25/2024',
    [string]   $Presenter = 'Gael',
    [string]   $Subject   = 'how to work with PowerShell modules'
)

function Get-MyDemoMessage
{
    param
    (
        [Parameter(Mandatory)]
        [DateTime] $EventDate,

        [Parameter(Mandatory)]
        [string]   $Presenter,

        [Parameter(Mandatory)]
        [string]   $Subject
    )

    if ($EventDate -eq [datetime]::Today)
    {
        'Today the {0}, {1} shows "{2}"!' -f @(
            '{0:d.MM.yyyy}' -f $EventDate
            $Presenter
            $Subject
        )
    }
    elseif ($EventDate -lt [datetime]::Today) 
    {
        'The event was {0} days ago, don''t worry!' -f ([datetime]::Today - $EventDate).Days
    }
    else
    {
        'The event is in {0} day(s)! Are you ready yet?' -f ($EventDate - [datetime]::Today).Days
    }
}

function Show-MyDemoEventMessage
{
    param
    (
        [Parameter(ValueFromPipeline)]
        [string]
        $Message
    )

    switch -regex ($Message)
    {
        'ago'        { Write-Host -ForegroundColor Green -Object $Message  }
        'ready\syet' { Write-Host -ForegroundColor Red -Object $Message }
        Default      { Write-Host -ForegroundColor Yellow -Object $Message }
    }
}

$MyParams = @{
    EventDate = $EventDate
    Presenter = $Presenter
    Subject   = $Subject
}

Get-MyDemoMessage @MyParams  | Show-MyDemoEventMessage

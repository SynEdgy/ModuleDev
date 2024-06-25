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

    $value = if ($EventDate -eq [datetime]::Today)
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

    $null = "this is another message"
    
    $value
}
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
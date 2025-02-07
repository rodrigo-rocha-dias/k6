param (
    [string]$InputFile, # Caminho para o arquivo JSON original
    [string]$OutputFile # Caminho para o arquivo JSON filtrado
)

if (-Not (Test-Path $InputFile)) {
    Write-Host "Arquivo de entrada não encontrado: $InputFile"
    exit 1
}

Write-Host "Lendo o arquivo de entrada: $InputFile"

$logData = Get-Content -Path $InputFile | ConvertFrom-Json

if ($null -eq $logData) {
    Write-Host "Log data está vazio ou nulo."
    exit 1
}

$filteredData = @()

foreach ($entry in $logData) {
    if ($entry.metric -eq 'http_req_failed' -or $entry.metric -eq 'http_req_receiving') {
        if ($entry.data -ne $null -and $entry.data.tags -ne $null) {
            $filteredEntry = @{
                time = $entry.data.time
                method = $entry.data.tags.method
                status = $entry.data.tags.status
                url = $entry.data.tags.url
            }
            $filteredData += $filteredEntry
        }
    }
}

if ($filteredData.Count -eq 0) {
    Write-Host "Nenhum dado foi filtrado."
    exit 1
}

$filteredData | ConvertTo-Json -Depth 3 | Set-Content -Path $OutputFile

Write-Host "Logs filtrados salvos em $OutputFile"

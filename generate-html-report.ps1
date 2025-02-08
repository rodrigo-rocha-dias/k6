param (
    [string]$InputFile,
    [string]$OutputFile
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

$totalRequests = ($logData | Measure-Object).Count
$failedRequests = ($logData | Where-Object { $_.status -ge 400 }).Count
$passedChecks = ($logData | Where-Object { $_.status -lt 400 }).Count
$breachedThresholds = ($logData | Where-Object { $_.status -ge 400 }).Count

# Cria o conteúdo HTML
$htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>Relatório de Testes K6</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .summary-boxes {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
        }
        .summary-box {
            width: 20%;
            padding: 10px;
            text-align: center;
            border-radius: 5px;
        }
        .summary-box.green {
            background-color: #d4edda;
            color: #155724;
        }
        .summary-box.red {
            background-color: #f8d7da;
            color: #721c24;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Relatório de Testes K6</h1>
    <div class="summary-boxes">
        <div class="summary-box green">
            <h2>Total Requests</h2>
            <p>$totalRequests</p>
        </div>
        <div class="summary-box green">
            <h2>Passed Checks</h2>
            <p>$passedChecks</p>
        </div>
        <div class="summary-box red">
            <h2>Failed Requests</h2>
            <p>$failedRequests</p>
        </div>
        <div class="summary-box red">
            <h2>Breached Thresholds</h2>
            <p>$breachedThresholds</p>
        </div>
    </div>
    <table>
        <tr>
            <th>Time</th>
            <th>Method</th>
            <th>Status</th>
            <th>URL</th>
        </tr>
"@

foreach ($entry in $logData) {
    $htmlContent += @"
        <tr>
            <td>$($entry.time)</td>
            <td>$($entry.method)</td>
            <td>$($entry.status)</td>
            <td>$($entry.url)</td>
        </tr>
"@
}

$htmlContent += @"
    </table>
</body>
</html>
"@

# Salva o conteúdo HTML no arquivo de saída
$htmlContent | Set-Content -Path $OutputFile

Write-Host "Relatório HTML gerado em $OutputFile"

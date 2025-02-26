param (
    [string]$VUs = "10",
    [string]$Duration = "5m",
    [string]$TESTS = "1,2,3,4,5,6,7,8",
    [int]$Iterations = 10,
    [string]$Release = "placeholder",
    [string]$Ambiente = "HML"
)

$PATH = Get-Location
$FolderName = "$PATH\reports"
$LogFolder = "$FolderName\logs"

Write-Host "Iniciando script run-load-test.ps1..."

# Criar a pasta reports caso não exista
if (-Not (Test-Path $FolderName)) {
    New-Item $FolderName -ItemType Directory
    Write-Host "Folder Created successfully" -ForegroundColor Green
} else {
    Write-Host "Folder Exists" -ForegroundColor Yellow
}

# Criar a pasta logs caso não exista
if (-Not (Test-Path $LogFolder)) {
    New-Item $LogFolder -ItemType Directory
    Write-Host "Log Folder Created successfully" -ForegroundColor Green
} else {
    Write-Host "Log Folder Exists" -ForegroundColor Yellow
}

$ConfigFile = "$PATH\config.json"

# Criar config.json caso não exista
Write-Host "Atualizando o arquivo config.json com os novos parâmetros"
$defaultConfig = @{
    vus        = [int]$VUs
    iterations = $Iterations
    duration   = $Duration
    nome_teste = $TESTS
    release    = $Release
    ambiente   = $Ambiente
} | ConvertTo-Json -Depth 3
$defaultConfig | Set-Content -Path $ConfigFile

# Carregar configurações
$Config = Get-Content -Path $ConfigFile | ConvertFrom-Json
$env:TESTS = $Config.nome_teste 

# Gerar nomes dos arquivos
$time = Get-Date -Format "yyyyMMdd_HHmmss"
$LogFile = "$LogFolder\test_$time.log"
$ReportFile = "$FolderName\test_$time.json"
$FilteredReportFile = "$FolderName\test_$time.filtered.json"
$HtmlReportFile = "$FolderName\test_$time.html"

# Verificar se o script do K6 existe
$K6Script = "$PATH\scripts\placeholder\resources.js"
if (-Not (Test-Path $K6Script)) {
    Write-Host "Erro: O script do K6 não foi encontrado em $K6Script" -ForegroundColor Red
    exit 1
}

Write-Host "Running K6 test with $($Config.vus) VUs for $($Config.duration) and TESTS $env:TESTS" -ForegroundColor Cyan
k6 run $K6Script --vus $($Config.vus) --duration $($Config.duration) --out json=$ReportFile | Tee-Object -FilePath $LogFile
Write-Host "Test completed. Logs saved at $LogFile" -ForegroundColor Green

if (Test-Path ".\filter-log.ps1") {
    .\filter-log.ps1 -InputFile $ReportFile -OutputFile $FilteredReportFile
    Write-Host "Filtered logs saved at $FilteredReportFile" -ForegroundColor Green
} else {
    Write-Host "Warning: filter-log.ps1 script not found. Skipping log filtering." -ForegroundColor Yellow
}

if (Test-Path $FilteredReportFile) {
    Write-Host "Gerando relatório HTML..." -ForegroundColor Cyan
    .\generate-html-report.ps1 -InputFile $FilteredReportFile -OutputFile $HtmlReportFile
    Write-Host "Relatório HTML gerado em $HtmlReportFile" -ForegroundColor Green
} else {
    Write-Host "Warning: Filtered report file not found. Skipping HTML report generation." -ForegroundColor Yellow
}

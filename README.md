# K6 Load Test Project

Este projeto é uma estrutura para testes de carga utilizando [K6](https://k6.io/), escrita em JavaScript e organizada para facilitar a execução e análise de testes de desempenho.

## 📁 Estrutura do Projeto

```
K6/
│── config/
│   ├── options.js              # Configurações globais do K6
│
│── data/
│   ├── .keep                   # Diretório para armazenar dados adicionais
│
│── reports/                    # Diretório para armazenar relatórios dos testes
│   ├── logs/                   # Arquivos de log dos testes
│
│── scripts/
│   ├── blaze/                  # Scripts específicos para o site Blaze
│   ├── httpbin/                # Scripts para testar a API HTTPBin
│   ├── placeholder/
│   │   ├── resources.js        # Script principal com os cenários de teste
│
│── utils/
│   ├── generator.js            # Gerador de dados dinâmicos
│   ├── requestMethods.js       # Métodos para requisições HTTP
│
│── .gitignore                  # Arquivos ignorados pelo Git
│── config.json                 # Configuração do teste (editável pelo usuário)
│── filter-log.ps1              # Script para filtrar os logs de teste
│── generate-html-report.ps1    # Script para gerar relatório HTML dos testes
│── jenkins.ps1                 # Script para integração com o Jenkins
│── package.json                # Dependências do projeto
│── README.md                   # Documentação do projeto
│── run-load-test.ps1           # Script principal para execução dos testes

```

## 🚀 Como Executar os Testes

### 1️⃣ Pré-requisitos

- ✅ Ter o [K6](https://k6.io/docs/getting-started/installation/) instalado na máquina.
- ✅ Ter o Node.js instalado (caso precise de bibliotecas adicionais).

---

### 🛠️ Instalação do K6 no Windows

#### 📦 Opção 1: Instalar via Chocolatey (recomendado)

Se você já tem o [Chocolatey](https://chocolatey.org/install) instalado:

```powershell
choco install k6 -y

Ou rode no PowerShell como administrador.

✅ Verifique se a instalação foi concluída:
k6 version

💡 Como instalar o Chocolatey (caso não tenha)
Abra o PowerShell como administrador e execute:

```
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = `
[System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

🔍 Verifique se foi instalado corretamente:
```
choco -v
```

📂 Opção 2: Instalação manual (sem Chocolatey)
Acesse: Releases do K6
Baixe o .zip da versão Windows (ex: k6-vX.X.X-windows-amd64.zip)
Extraia os arquivos para uma pasta de sua preferência, por exemplo:
C:\Tools\k6

Adicione essa pasta ao PATH do sistema:
Vá em Painel de Controle > Sistema > Configurações avançadas do sistema
Clique em Variáveis de Ambiente

Em Path, clique em Editar e adicione:
```
C:\Tools\k6
```

Reinicie o terminal/VSCode

✅ Verifique se o K6 está funcionando:
```
k6 version
```


✅ Verificação de Instalação
Se tiver problemas com o comando k6, verifique onde o executável está localizado:
```
Get-ChildItem -Path "C:\" -Recurse -Filter "k6.exe" -ErrorAction SilentlyContinue -Force
```


### 2️⃣ Configuração do Teste


Há duas formas de definir os parâmetros dos testes:

- Método 1️⃣: Via config.json (método padrão)

- Método 2️⃣: Via run-load-test.ps1 (sobrescreve configurações do config.json)


📌 Método 1️⃣: Configurar via config.json

Edite o arquivo config.json conforme necessário:

```
{
    "vus": 10,
    "duration": "30s",
    "iterations": 5,
    "release": "placeholder",
    "nome_teste": "1,2",
    "ambiente": "HML"
}
```

📌 Método 2️⃣: Configurar via run-load-test.ps1

Se preferir, você pode definir os parâmetros diretamente ao executar o script:

```
.\run-load-test.ps1 
-VUs 10 
-Duration "30s" 
-Iterations 5 
-Release "placeholder" 
-Ambiente "HML" 
-TESTS "1,2"
```


```
param (
    [string]$VUs = "10",               # Número de usuários virtuais
    [string]$Duration = "30s",         # Duração do teste
    [string]$TESTS = "1,2",            # Identificadores dos testes a executar
    [int]$Iterations = 5,              # Número de iterações por usuário
    [string]$Release = "placeholder",  # Nome da release/teste
    [string]$Ambiente = "HML"          # Ambiente de execução (HML, PRD, DEV)
)
```

Importante: Se você executar run-load-test.ps1 sem parâmetros, ele usará os valores do config.json.


### 📊 Analisando os Resultados

Após a execução do teste, os relatórios serão gerados na pasta reports/.

1️⃣ Relatório em JSON
O K6 gera um arquivo JSON contendo os resultados do teste, que pode ser analisado manualmente ou convertido para HTML.

2️⃣ Gerando Relatório em HTML
Para gerar um relatório visual a partir do JSON gerado, execute:
```
.\generate-html-report.ps1 -InputFile "reports/test_20250226.json" -OutputFile "reports/test_20250226.html"
```
Nota: Substitua "test_20250226.json" pelo nome real do arquivo gerado.


### 📊 Interpretando os Resultados

Os principais indicadores de desempenho incluem:

| 📊 Métrica                       | 📌 Descrição                                                             |
|----------------------------------|--------------------------------------------------------------------------|
| http_req_duration                | Tempo total da requisição (inclui DNS, conexão e tempo de resposta)       |
| http_req_waiting                 | Tempo de espera para o servidor responder após o envio da requisição      |
| http_req_connecting              | Tempo de conexão TCP entre cliente e servidor                             |
| http_req_blocked                 | Tempo em que a requisição ficou bloqueada (ex.: limitação de conexões)    |
| http_req_receiving               | Tempo para receber a resposta do servidor                                 |
| http_req_sending                 | Tempo gasto enviando dados para o servidor                                |
| http_reqs                        | Número total de requisições realizadas                                    |
| iteration_duration               | Tempo médio para cada iteração completa (um ciclo de usuário)             |
| vus                              | Número de usuários virtuais ativos                                        |
| vus_max                          | Número máximo de usuários simultâneos durante o teste                     |
| iterations                       | Número total de iterações executadas                                      |
| data_received                    | Quantidade de dados recebidos (em bytes)                                  |
| data_sent                        | Quantidade de dados enviados (em bytes)                                   |
| checks                           | Número total de validações de testes de sucesso                           |
| http_req_failed                  | Percentual de requisições que falharam                                    |
| http_req_duration{p(90)}         | Tempo de resposta para 90% das requisições                                |
| http_req_duration{p(95)}         | Tempo de resposta para 95% das requisições                                |
| http_req_duration{p(99)}         | Tempo de resposta para 99% das requisições                                |


🎯 Como analisar?
- 1️⃣ Se http_req_duration estiver muito alto, o tempo de resposta do servidor pode estar ruim.
- 2️⃣ Se http_req_failed for maior que 0%, houve falhas nas requisições, indicando possíveis erros no servidor.
- 3️⃣ Se vus_max for menor do que o esperado, pode haver um gargalo impedindo mais usuários simultâneos.
- 4️⃣ Se http_req_duration{p(90)} e http_req_duration{p(95)} forem altos, significa que 90% ou 95% das requisições estão demorando demais.


### 3️⃣ Gerando Relatório

Após a execução dos testes, um relatório JSON será salvo na pasta `reports/`. Para gerar um relatório HTML, execute:
```powershell
.\generate-html-report.ps1 -InputFile "reports/test_xxxx.json" -OutputFile "reports/test_xxxx.html"
```

## 🛠 Funcionalidades

- **Requisições HTTP personalizadas**: Os métodos de requisição estão definidos em `utils/requestMethods.js`.
- **Execução parametrizável**: Os parâmetros do teste podem ser configurados via `config.json` ou linha de comando.
- **Geração de relatório HTML**: Após os testes, um relatório visual pode ser gerado para análise.
- **Integração com Jenkins**: O script `jenkins.ps1` auxilia na execução automatizada dentro do Jenkins.


## 📚 Referências
- [Documentação do K6](https://k6.io/docs/)
- [Boas práticas para testes de carga](https://k6.io/docs/testing-guides/best-practices-load-testing/)

---

# K6 Performance Testing

Este repositório contém testes de carga e desempenho utilizando [K6](https://k6.io/). Ele está estruturado para facilitar a reutilização de código e a integração com o Jenkins.

## 📂 Estrutura do Projeto

```
K6/
│-- config/
│   ├── options.js            # Configurações globais do K6
│
│-- data/
│   ├── (Arquivos JSON, CSV ou outros dados usados nos testes)
│
│-- report/
│   ├── logs/
│   │   ├── summary.json      # Resumo da execução
│   │   ├── summary.html      # Relatório em HTML
│   │   ├── htmlReport.js     # Script para gerar relatório HTML
│
│-- scripts/
│   ├── plataformaTestes/     # Testes para a Plataforma de Testes
│   │   ├── auth/
│   │   │   ├── login.js     # Testes de login
│   │   ├── user/            # Testes relacionados a usuários
│
│-- utils/
│   ├── guidGenerator.js      # Função para gerar GUIDs
│   ├── helpers.js            # Funções auxiliares gerais
│   ├── jwt.js                # Manipulação de tokens JWT
│   ├── passwordGenerator.js  # Geração de senhas aleatórias
│   ├── randomNumber.js       # Geração de números aleatórios
│   ├── requestMethods.js     # Métodos reutilizáveis para requisições HTTP
│
│-- .gitignore                # Arquivos ignorados pelo Git
│-- index.js                  # Ponto de entrada do projeto
│-- jenkins.ps1               # Script para execução no Jenkins
│-- package.json              # Dependências do projeto
│-- run-load-test.ps1         # Script para rodar os testes
│-- README.md                 # Documentação do projeto
```

## 🛠 Instalação

Certifique-se de ter o **[Chocolatey](https://chocolatey.org/)** instalado e, em seguida, instale o K6:

```powershell
choco install k6 -y
```

## 🚀 Como Executar os Testes

### Executar um teste específico:
```powershell
k6 run scripts/plataformaTestes/auth/login.js
```

### Executar testes em lote:
```powershell
./run-load-test.ps1
```

## 📊 Geração de Relatórios

Após a execução dos testes, os relatórios serão gerados na pasta `report/logs/`.
Para visualizar o relatório HTML:
```powershell
start report/logs/summary.html
```

## 🤖 Integração com Jenkins

Para rodar os testes no Jenkins, utilize o script `jenkins.ps1`. Certifique-se de configurar o pipeline corretamente para chamar este script.

---

Caso precise de melhorias na estrutura ou documentação, sinta-se à vontade para contribuir! 🚀


# K6 Load Test Project

Este projeto é uma estrutura para testes de carga utilizando [K6](https://k6.io/), escrita em JavaScript e organizada para facilitar a execução e análise de testes de desempenho.

## 📁 Estrutura do Projeto

```
K6/
│── config/
│   ├── options.js       # Configurações globais do K6
│
│── data/
│   ├── .keep            # Diretório para armazenar dados adicionais
│
│── reports/             # Diretório para armazenar relatórios dos testes
│
│── scripts/
│   ├── blaze/           # Scripts específicos para o site Blaze
│   ├── httpbin/         # Scripts para testar a API HTTPBin
│   ├── placeholder/
│   │   ├── resources.js # Script principal com os cenários de teste
│
│── utils/
│   ├── generator.js     # Gerador de dados dinâmicos
│   ├── requestMethods.js # Métodos para requisições HTTP
│
│── .gitignore           # Arquivos ignorados pelo Git
│── config.json          # Configuração do teste (editável pelo usuário)
│── filter-log.ps1       # Script para filtrar os logs de teste
│── generate-html-report.ps1 # Script para gerar relatório HTML dos testes
│── jenkins.ps1          # Script para integração com o Jenkins
│── package.json         # Dependências do projeto
│── README.md            # Documentação do projeto
│── run-load-test.ps1    # Script principal para execução dos testes
```

## 🚀 Como Executar os Testes

### 1️⃣ Pré-requisitos
- Ter o [K6](https://k6.io/docs/getting-started/installation/) instalado na máquina.
- Ter o Node.js instalado (caso precise de bibliotecas adicionais).

### 2️⃣ Configuração do Teste

Os parâmetros de execução podem ser configurados no arquivo `config.json`:
```json
{
    "vus": 1,
    "release": "placeholder",
    "duration": "5s",
    "iterations": 1,
    "nome_teste": "1",
    "ambiente": "HML"
}
```

### 3️⃣ Executando os Testes

Para iniciar um teste de carga, execute o script PowerShell:
```powershell
.
un-load-test.ps1 -VUs 10 -Duration "30s" -TESTS "1,2" -Iterations 5
```

Este comando executará os testes `1` e `2` por `30` segundos, com `10` usuários simultâneos e `5` iterações.

### 4️⃣ Gerando Relatório

Após a execução dos testes, um relatório JSON será salvo na pasta `reports/`. Para gerar um relatório HTML, execute:
```powershell
.\generate-html-report.ps1 -InputFile "reports/test_xxxx.json" -OutputFile "reports/test_xxxx.html"
```

## 🛠 Funcionalidades

- **Requisições HTTP personalizadas**: Os métodos de requisição estão definidos em `utils/requestMethods.js`.
- **Execução parametrizável**: Os parâmetros do teste podem ser configurados via `config.json` ou linha de comando.
- **Geração de relatório HTML**: Após os testes, um relatório visual pode ser gerado para análise.
- **Integração com Jenkins**: O script `jenkins.ps1` auxilia na execução automatizada dentro do Jenkins.

## 📌 Configuração Avançada

- Modifique o arquivo `config/options.js` para definir thresholds personalizados.
- Adicione novos cenários de teste no diretório `scripts/placeholder/`.
- Utilize `filter-log.ps1` para processar os logs gerados e remover dados irrelevantes.

## 📚 Referências
- [Documentação do K6](https://k6.io/docs/)
- [Boas práticas para testes de carga](https://k6.io/docs/testing-guides/best-practices-load-testing/)

---

Este projeto foi desenvolvido para facilitar a criação e execução de testes de carga automatizados. Caso tenha dúvidas ou sugestões, sinta-se à vontade para contribuir! 🚀


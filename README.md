

## Sumário ##

- [**Instalação do AWS CLI no Windows**](#Instalação-e-Uso-do-AWS-CLI-no-Windows)
- [**Instalação do Terraform no Windows**](#Instalação-e-Uso-do-Terraform-no-Windows)
- [**Criação e Uso de Pipeline com GitHub Actions**](#Criação-e-Uso-de-Pipeline-com-GitHub-Actions)
- [**Configuração do Backend Remoto para Armazenamento do Estado**](@Configuracao-do-Backend-Remoto)
- [**Exemplo de payload do SQS**](#Exemplo-de-payload-do-SQS)

# Instalação e Uso do AWS CLI no Windows

Este guia descreve os passos para instalar e configurar a AWS Command Line Interface (AWS CLI) em um ambiente Windows.

## 1. Pré-requisitos

- Sistema Operacional: Windows 10 ou superior
- Conta na AWS com chaves de acesso (Access Key ID e Secret Access Key)
- Permissão de administrador para instalar programas

## 2. Instalação do AWS CLI

### Passo 1: Baixar o instalador

1. Acesse: [https://aws.amazon.com/cli/](https://aws.amazon.com/cli/)
2. Clique em **Download** e escolha o instalador para Windows (64-bit). Ou acesse diretamente:  
   [https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html)

### Passo 2: Instalar o AWS CLI

1. Execute o instalador `.msi` baixado.
2. Siga os passos do assistente de instalação.

### Passo 3: Verificar a instalação

Abra o **Prompt de Comando** e execute:

```bash
aws --version
```

Você deverá ver algo como:

```
aws-cli/2.x.x Python/3.x.x Windows/10 exe/x86_64
```

## 3. Configurar o AWS CLI

Execute o comando abaixo no Prompt de Comando:

```bash
aws configure
```

Você será solicitado a informar:

1. AWS Access Key ID
2. AWS Secret Access Key
3. Região padrão (ex: `us-east-1`)
4. Formato de saída (ex: `json`, `table` ou `text`)

Essas informações são armazenadas no diretório:

```
C:\Users\<seu-usuario>\.aws\
```

## 4. Comandos Básicos do AWS CLI

| Comando                                         | Descrição                                     |
|------------------------------------------------|-----------------------------------------------|
| `aws s3 ls`                                    | Lista os buckets S3                          |
| `aws ec2 describe-instances`                  | Lista instâncias EC2                         |
| `aws s3 cp arquivo.txt s3://meu-bucket/`      | Copia um arquivo para o S3                   |
| `aws lambda list-functions`                   | Lista as funções Lambda                      |

## 5. Atualizar o AWS CLI

Execute o instalador mais recente, como na instalação inicial. O processo de atualização é automático.

## 6. Desinstalar o AWS CLI

1. Vá em **Painel de Controle** > **Programas e Recursos**
2. Localize **AWS Command Line Interface v2**
3. Clique em **Desinstalar**

---

📘 Documentação oficial: [https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)


# Instalação e Uso do Terraform no Windows

Este guia descreve os passos para instalar e utilizar o Terraform em um ambiente Windows.

## 1. Pré-requisitos

- Sistema Operacional: Windows 10 ou superior
- Acesso à internet
- Permissão de administrador para instalar programas

## 2. Instalação do Terraform

### Passo 1: Baixar o Terraform

1. Acesse o site oficial do Terraform: [https://developer.hashicorp.com/terraform/downloads](https://developer.hashicorp.com/terraform/downloads)
2. Selecione a versão do Windows (64-bit).
3. Baixe o arquivo `.zip`.

### Passo 2: Extrair e configurar o PATH

1. Extraia o conteúdo do `.zip` em uma pasta de sua preferência, por exemplo: `C:\Terraform`.
2. Adicione essa pasta ao PATH do sistema:
   - Pressione `Win + R`, digite `sysdm.cpl` e pressione Enter.
   - Vá até a aba **Avançado** > clique em **Variáveis de Ambiente**.
   - Na seção **Variáveis do sistema**, selecione **Path** > clique em **Editar**.
   - Clique em **Novo** e adicione o caminho onde você extraiu o Terraform.
   - Clique em **OK** para salvar.

### Passo 3: Verificar a instalação

Abra o **Prompt de Comando** e digite:

```bash
terraform -v
```

Você deve ver a versão do Terraform instalada.

## 3. Criando seu primeiro projeto Terraform

### Passo 1: Criar diretório do projeto

```bash
mkdir meu-projeto-terraform
cd meu-projeto-terraform
```

### Passo 2: Criar um arquivo de configuração

Crie um arquivo `main.tf` com o seguinte conteúdo de exemplo (para provisionar um recurso fictício):

```hcl
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
  }
}

resource "random_pet" "nome" {
  length = 2
}
```

### Passo 3: Inicializar o Terraform

```bash
terraform init
```

### Passo 4: Verificar o que será criado

```bash
terraform plan
```

### Passo 5: Aplicar as mudanças

```bash
terraform apply
```

Digite `yes` para confirmar.

## 4. Comandos úteis do Terraform

| Comando               | Descrição                              |
|-----------------------|------------------------------------------|
| `terraform init`     | Inicializa um novo projeto Terraform     |
| `terraform plan`     | Mostra o que será criado/modificado      |
| `terraform apply`    | Aplica as mudanças no ambiente           |
| `terraform destroy`  | Remove todos os recursos criados         |

## 5. Dicas Finais

- Nunca compartilhe seus arquivos `.tfstate` ou credenciais.
- Utilize variáveis e arquivos `.tfvars` para organizar melhor seus projetos.

---

📘 Documentação oficial: [https://developer.hashicorp.com/terraform/docs](https://developer.hashicorp.com/terraform/docs)

---


# Criação e Uso de Pipeline com GitHub Actions

Este guia mostra como criar, configurar e utilizar uma pipeline de CI/CD com o GitHub Actions.

## 1. O que é GitHub Actions?

GitHub Actions é a ferramenta de automação nativa do GitHub, permitindo criar pipelines para integração contínua (CI) e entrega contínua (CD) usando arquivos YAML dentro do repositório.

## 2. Estrutura dos Workflows

- Os workflows ficam na pasta `.github/workflows/` dentro do repositório.
- Cada pipeline é definida em um arquivo `.yml`.

## 3. Criando um Workflow Básico

### Passo 1: Criar a pasta e o arquivo do workflow

Dentro do seu repositório local:

```bash
mkdir -p .github/workflows
```
Crie o arquivo `.github/workflows/ci.yml` com o conteúdo abaixo.

### Passo 2: Exemplo de pipeline para projeto Node.js

```yaml
name: CI Pipeline

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout do código
      uses: actions/checkout@v3

    - name: Instalar Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'

    - name: Instalar dependências
      run: npm install

    - name: Rodar testes
      run: npm test
```

### Explicando o workflow:

- `on`: Define os eventos que disparam a pipeline (`push` e `pull_request` para o branch `main`).
- `jobs`: Um ou mais blocos de tarefas executadas em runners.
- `steps`: Etapas dentro de um job (checkout do código, instalação de dependências, testes, etc).

## 4. Acompanhando o pipeline

1. Vá até a aba **Actions** no seu repositório no GitHub.
2. Clique em um dos workflows executados para ver os logs em tempo real.

## 5. Exemplo para projeto Python

```yaml
name: Python CI

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3

    - name: Configurar Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.11'

    - name: Instalar dependências
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt

    - name: Rodar testes
      run: |
        pytest
```

## 6. Dicas

- Use secrets do GitHub (`Settings > Secrets`) para armazenar tokens ou chaves de acesso.
- Crie arquivos separados para workflows de build, deploy, lint, etc.
- Combine GitHub Actions com outras ferramentas como Docker, AWS CLI, Terraform, etc.

## 7. Links úteis

- 📘 Documentação oficial: [https://docs.github.com/actions](https://docs.github.com/actions)
- 📁 Repositório de exemplos: [https://github.com/actions/starter-workflows](https://github.com/actions/starter-workflows)

--

# Configuracao-do-Backend-Remoto
- Crie ma tabela no dynamodb para controlar o locking. A tabela do DynamoDB precisa ter uma estrutura simples, com apenas uma chave primária (partition key) chamada **LockID** do tipo String.
- Nas conigurações do terraform, confugure o bucket que armazenará o estado.

Exemplo:
```
backend "s3" {
  bucket         = "terraform-estados"              
  key            = "minha-infra/terraform.tfstate"
  region         = "us-east-1"
  encrypt        = true
  dynamodb_table = "terraform-lock"
}
```

**onde**:  
  **bucket**: nome do bucket S3 onde o estado será salvo.  
  **key**: caminho do arquivo .tfstate dentro do bucket.  
  **region**: região AWS onde está o bucket e o DynamoDB.  
  **encrypt**: habilita criptografia do arquivo de estado em repouso no S3.  
  **dynamodb_table**: nome da tabela do DynamoDB usada para fazer locking do state file e evitar condições de corrida (duas execuções concorrentes).  
  
# Exemplo de payload do SQS

```
{
  "Records": [
    {
      "messageId": "f29a1e2d-5bb4-48b2-8bfa-9e40160ef7df",
      "receiptHandle": "AQEBJ+v+...truncated...==",
      "body": "{\"nome\": \"José\", \"idade\": 35}",
      "attributes": {
        "ApproximateReceiveCount": "1",
        "SentTimestamp": "1719342940000",
        "SenderId": "AIDAEXAMPLEID",
        "ApproximateFirstReceiveTimestamp": "1719342941234"
      },
      "messageAttributes": {
        "source": {
          "stringValue": "sistemaA",
          "dataType": "String"
        }
      },
      "md5OfBody": "098f6bcd4621d373cade4e832627b4f6",
      "eventSource": "aws:sqs",
      "eventSourceARN": "arn:aws:sqs:us-east-1:123456789012:minha-fila",
      "awsRegion": "us-east-1"
    }
  ]
}

```
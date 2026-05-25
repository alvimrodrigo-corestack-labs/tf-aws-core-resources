# Core Infrastructure Resources (AWS)

Este repositório é responsável pela orquestração dos recursos de infraestrutura compartilhada (Core) da organização **CoreStack Labs**. Ele utiliza **Terragrunt** para manter as configurações DRY e gerenciar as dependências entre componentes.

## 🏗 Arquitetura

A estrutura segue o padrão de **Live Architecture**, onde os recursos são divididos por ambientes e componentes desacoplados:

\`\`\`text
.
├── root.hcl                # Configurações globais (S3 Remote State, Providers)
├── .github/workflows/      # Automação de CI/CD (GitHub Actions)
└── environments/
    └── dev/                # Ambiente de Desenvolvimento
        ├── network/        # VPC, Subnets, IGW, NAT Gateway
        ├── security-groups/# SGs compartilhados (ex: ALB SG)
        ├── load-balancer/  # Application Load Balancer (ALB)
        └── ecs-cluster/    # Cluster ECS Fargate
\`\`\`

## 🛠 Tecnologias Utilizadas

*   **Terraform**: Infraestrutura como Código (IaC).
*   **Terragrunt**: Orquestrador para múltiplos módulos e estados remotos.
*   **AWS**: Provedor de Nuvem (VPC, ECS, ALB, S3, DynamoDB).
*   **GitHub Actions**: Pipeline de CI/CD.

## 🚀 Como Utilizar

### Requisitos Locais

*   Terraform >= 1.7.0
*   Terragrunt >= 0.55.0
*   AWS CLI configurado com permissões apropriadas.

### Comandos Comuns

\`\`\`bash
# Entrar no ambiente desejado
cd environments/dev

# Visualizar o plano de todos os recursos do ambiente
terragrunt run --all plan

# Aplicar as mudanças (apenas após aprovação no PR)
terragrunt run --all apply
\`\`\`

## 🤖 CI/CD & GitOps

O fluxo de trabalho é totalmente automatizado via GitHub Actions:

1.  **Pull Request**: Dispara um \`terragrunt plan\` automático. O resultado é comentado no PR para revisão técnica.
2.  **Merge na Main**: Dispara o \`terragrunt apply\` automático.
3.  **Cost Control (Destroy)**: Existe um workflow manual chamado \`Terragrunt Destroy\` para limpar todos os recursos e economizar custos de laboratório. **Exige confirmação digitando "DESTROY"**.

## 🔐 Segurança e Boas Práticas

*   **Estado Remoto**: Armazenado em S3 com trava (lock) via DynamoDB.
*   **Acesso Restrito**: Security Groups configurados para permitir acesso apenas a IPs autorizados (Inbound restrito).
*   **Módulos Reutilizáveis**: Este repositório consome módulos versionados do repositório [tf-aws-modules](https://github.com/alvimrodrigo-corestack-labs/tf-aws-modules).
*   **FinOps**: Uso de \`single_nat_gateway\` e \`Fargate Spot\` para redução de custos em ambiente de desenvolvimento.

---
**CoreStack Labs** - *Platform Engineering Team*

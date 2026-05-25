include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "network" {
  config_path = "../network"
  
  mock_outputs = {
    vpc_id = "vpc-mock-id"
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

terraform {
  source = "git::git@github.com:alvimrodrigo-corestack-labs/tf-aws-modules.git//modules/security-group?ref=main"
}

inputs = {
  name        = "corestack-alb-sg-dev"
  description = "Security Group para o Application Load Balancer - Acesso Restrito"
  vpc_id      = dependency.network.outputs.vpc_id

  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["162.120.186.84/32"]
      description = "Allow HTTP from User IP only"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["162.120.186.84/32"]
      description = "Allow HTTPS from User IP only"
    }
  ]

  # Outbound já é liberado por padrão no módulo, mas deixamos explícito aqui para segurança
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]
}

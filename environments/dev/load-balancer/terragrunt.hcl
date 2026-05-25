include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "network" {
  config_path = "../network"
  
  mock_outputs = {
    vpc_id            = "vpc-mock-id"
    public_subnet_ids = ["subnet-mock-1", "subnet-mock-2"]
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

dependency "security_groups" {
  config_path = "../security-groups"
  
  mock_outputs = {
    security_group_id = "sg-mock-id"
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

terraform {
  source = "git::git@github.com:alvimrodrigo-corestack-labs/tf-aws-modules.git//modules/alb?ref=main"
}

inputs = {
  name    = "corestack-alb-dev"
  vpc_id  = dependency.network.outputs.vpc_id
  subnets = dependency.network.outputs.public_subnet_ids
  
  security_groups = [dependency.security_groups.outputs.security_group_id]

  # Listener HTTP Porta 80 pronto para receber múltiplas Apps
  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      default_action = {
        type = "fixed-response"
        fixed_response = {
          content_type = "text/plain"
          message_body = "CoreStack Labs - ALB Ready. No app rules matched."
          status_code  = "404"
        }
      }
    }
  ]
}

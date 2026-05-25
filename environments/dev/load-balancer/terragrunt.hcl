include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "network" {
  config_path = "../network"
  
  mock_outputs = {
    vpc_id         = "vpc-mock-id"
    public_subnets = ["subnet-mock-1", "subnet-mock-2"]
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

terraform {
  source = "git::git@github.com:alvimrodrigo-corestack-labs/tf-aws-modules.git//modules/alb?ref=main"
}

inputs = {
  name    = "corestack-alb-dev"
  vpc_id  = dependency.network.outputs.vpc_id
  subnets = dependency.network.outputs.public_subnets
  
  security_groups = [] 
}

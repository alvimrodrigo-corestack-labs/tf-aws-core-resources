include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "network" {
  config_path = "../network"
  
  mock_outputs = {
    vpc_id             = "vpc-mock-id"
    private_subnet_ids = ["subnet-mock-3", "subnet-mock-4"]
  }
  mock_outputs_allowed_terraform_commands = ["plan"]
}

terraform {
  source = "git::git@github.com:alvimrodrigo-corestack-labs/tf-aws-modules.git//modules/ecs-cluster?ref=main"
}

inputs = {
  name = "corestack-cluster-dev"
}

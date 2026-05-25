include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "network" {
  config_path = "../network"
}

terraform {
  source = "git::git@github.com:alvimrodrigo-corestack-labs/tf-aws-modules.git//modules/alb?ref=main"
}

inputs = {
  name           = "corestack-alb-dev"
  vpc_id         = dependency.network.outputs.vpc_id
  public_subnets = dependency.network.outputs.public_subnets
}

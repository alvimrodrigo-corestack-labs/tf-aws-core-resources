include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "network" {
  config_path = "../network"
}

terraform {
  source = "git::git@github.com:alvimrodrigo-corestack-labs/tf-aws-modules.git//modules/ecs-cluster?ref=main"
}

inputs = {
  cluster_name = "corestack-cluster-dev"
  vpc_id       = dependency.network.outputs.vpc_id
  subnets      = dependency.network.outputs.private_subnets
}

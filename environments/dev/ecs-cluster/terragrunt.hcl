include "root" {
  path = find_in_parent_folders()
}

dependency "network" {
  config_path = "../network"
}

terraform {
  source = "../../../../tf-aws-modules//modules/ecs-cluster"
}

inputs = {
  cluster_name = "corestack-cluster-dev"
  vpc_id       = dependency.network.outputs.vpc_id
  subnets      = dependency.network.outputs.private_subnets
}

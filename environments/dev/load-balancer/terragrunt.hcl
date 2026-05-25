include "root" {
  path = find_in_parent_folders()
}

dependency "network" {
  config_path = "../network"
}

terraform {
  source = "../../../../tf-aws-modules//modules/alb"
}

inputs = {
  name           = "corestack-alb-dev"
  vpc_id         = dependency.network.outputs.vpc_id
  public_subnets = dependency.network.outputs.public_subnets
}

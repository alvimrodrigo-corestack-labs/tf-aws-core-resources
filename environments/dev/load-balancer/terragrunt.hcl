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
  name    = "corestack-alb-dev"
  vpc_id  = dependency.network.outputs.vpc_id
  subnets = dependency.network.outputs.public_subnets
  
  # Como o módulo exige security_groups e ainda não temos um módulo de SG, 
  # vou passar uma lista vazia ou criar um SG no core-resources futuramente.
  # Por agora, para passar no Plan:
  security_groups = [] 
}

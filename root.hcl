locals {
  region = "us-east-1"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "tf-state-corestack-labs-rodrigo"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.region
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<PROV
provider "aws" {
  region = "${local.region}"
  default_tags {
    tags = {
      Project   = "CoreStackLabs"
      ManagedBy = "Terragrunt"
      Owner     = "Rodrigo"
    }
  }
}
PROV
}

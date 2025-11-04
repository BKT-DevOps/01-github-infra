terraform {
  backend "s3" {
    bucket  = "seyid-terraform-state"
    key     = "01-github-infra/terraform.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }

  required_version = ">= 1.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6"
    }

  }
}
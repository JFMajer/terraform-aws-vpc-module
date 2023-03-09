terraform {
  required_version = ">= 0.1.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  
  backend "s3" {
    bucket = "terraform-state-4632746528"
    key    = "vpc/terraform.tfstate"
    region = "eu-north-1"
    dynamodb_table = "terraform-state"
    encrypt = true
  }
}

provider "aws" {
  region = "eu-north-1"
}

module "vpc" {
    source = "../"
    vpc_cidr = "10.0.0.0/16"
    public_subnets_count = 2
    private_subnets_count = 2    
}
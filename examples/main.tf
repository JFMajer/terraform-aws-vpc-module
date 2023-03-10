terraform {
  required_version = ">= 0.1.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  
  backend "s3" {
    bucket = "#{S3_BUCKET}#"
    key    = "vpc-test/terraform.tfstate"
    region = "#{AWS_REGION}#"
    dynamodb_table = "#{DYNAMO_TABLE}#"
    encrypt = true
  }
}

provider "aws" {
  region = "#{AWS_REGION}#"
  assume_role {
    role_arn = "#{AWS_ROLE_TO_ASSUME}#"
  }
  default_tags {
    tags = {
      Environment = "#{ENV}#"
      ManagedBy = "terraform"
    }
  }
}

module "vpc" {
    source = "../"
    vpc_cidr = "10.0.0.0/16"
    public_subnets_count = 2
    private_subnets_count = 2
    name_prefix = "#{ENV}#"    
}
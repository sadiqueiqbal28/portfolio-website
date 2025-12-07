terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.23.0"
    }
  }
  backend "s3" {
    bucket = "sadique-terra-state-bucket"
    key = "terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    use_lockfile = true
  }
}
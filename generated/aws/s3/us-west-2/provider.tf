provider "aws" {
  region = "us-west-2"
}

terraform {
	required_providers {
		aws = {
	    version = "~> 6.0.0"
		}
  }
}

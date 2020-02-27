#provider "aws" {
#  region = "var.AWS_REGION"
#  access_key = "var.AWS_ACCESS_KEY"
#  secret_key = "var.AWS_SECRET_KEY"
#}

provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}


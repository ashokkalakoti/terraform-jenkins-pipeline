terraform {
  backend "s3" {
    bucket = "my-example-terraform-module-bucket1"
    key    = "projects/project-jenkins02/terraform.tfstate"
    region = "ap-southeast-1"
  }
}


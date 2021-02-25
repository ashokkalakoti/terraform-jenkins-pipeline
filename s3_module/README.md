## S3 private bucket module with versioning and encryption with default kms

# usage: 

This module can be download from version control system

```
module "s3_bucket" {
    source                  = "https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/terraform-repo/s3_module"
    s3_bucket_name          = "my-example-terraform-module-bucket1"
    versioning_enable       = "true"
    environment             = "SIT"
    project_name            = "POC"
}

```


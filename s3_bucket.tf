module "s3_bucket" {
    source                  = "./s3_module"
    s3_bucket_name          = "my-example-terraform-module-bucket2"
    versioning_enable       = "true"
    environment             = "UAT"
    project           	     = "project-jenkins"
}

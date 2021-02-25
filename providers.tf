provider "aws" {
  region = "ap-southeast-1"
    assume_role {
    # The role ARN within Account B to AssumeRole into. Created in step 1.
    role_arn    = "arn:aws:iam::864610509831:role/Terraform_assume_role"
    # (Optional) The external ID created in step 1c.
    #external_id = "my_external_id"
  }
}



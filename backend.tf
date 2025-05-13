#Terraform does not allow variables inside the backend block. You must hardcode the values.
terraform {
  backend "s3" {
    bucket         = "terraform-backend-bucket-proj1"             #your terraform bucket name
    key            = "terraform-proj1/terraform.tfstate"          #path to your terraform.tfstate
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"                       #your dynamodb table name
    encrypt        = true
  }
}

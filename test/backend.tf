/*# Backend must remain commented until the Bucket
 and the DynamoDB table are created. 
 After the creation you can uncomment it,
 run "terraform init" and then "terraform apply" */
terraform {
  backend "s3" {
    bucket         = "infrastructure-terraform-state-backend"
    key            = "terraform-on-aws/web-app.tfstate"
    region         = "eu-west-2"
    # dynamodb_table = "terraform_state"
  }
}
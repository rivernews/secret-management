terraform {
  backend "s3" {
    bucket = "iriversland-cloud"
    key    = "terraform/secret-management.remote-terraform.tfstate"
  }
}

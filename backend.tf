terraform {
  backend "s3" {
    bucket = "iriversland-cloud"
    key    = "terraform/selenium-service.remote-terraform.tfstate"
  }
}

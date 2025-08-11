terraform {
  backend "s3" {
    bucket = "my-app-bucket-564"
    region = "us-east-1"
    key = "terraform.tfstate"
    
  }
}
provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "my_instance" {
    ami = "ami-08a6efd148b1f7504"  
    instance_type = "t2.micro"
}
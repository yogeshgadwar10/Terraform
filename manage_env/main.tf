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
module "new_vpc" {
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    pri_sub_cidr = var.pri_cidr
    pub_sub_cidr = var.pub_cidr
    env = var.env
    project = var.project
    az = var.az
}

module "instance" {
    source = "./modules/ec2"
    image_id = var.ami
    instance_type = var.instance_type
    subnet_id = module.new_vpc.pub_subnet_id
    vpc_id = module.new_vpc.vpc_id
    key_pair = var.key
    project = var.project
}


provider "aws" {
   region = "us-east-1"  
}

# # VPC

# module "new_vpc" {
#     source = "./modules/vpc"
#     vpc_cidr = "172.16.0.0/16"
#     pri_sub_cidr = "172.16.0.0/20"
#     pub_sub_cidr = "172.16.16.0/20"
    
# }

# # instance

# module "instance" {
#     source = "./modules/ec2"
#     image_id =  "ami-020cba7c55df1f615"
#     subnet_id = module.new_vpc.pub_subnet_id
#     vpc_id = module.new_vpc.vpc_id
#     key_pair = "Yogesh-YG"
#     project = "prac"
#     depends_on = [ module.new_vpc ]
# }    

# # S-Bucket

# module "my_s3_bucket" {
#   source            = "./modules/s3"
#   bucket_name       = "my-app-bucket-564"
#   enable_versioning = true
#   enable_encryption = true
#   tags = {
#     Environment = "Dev"
#     Project     = "MyAppyo3"
#   }
# }

resource "aws_iam_instance_profile" "ima_role" {
  name = "ima-role"
  role = aws_iam_role.s3-role
}

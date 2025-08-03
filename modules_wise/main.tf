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

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "example"
  kubernetes_version = "1.33"

  # Optional
  endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = "vpc-1234556abcdef"
  subnet_ids = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "my-cluster"
  kubernetes_version = "1.33"

  addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
  }

  # Optional
  endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = "vpc-1234556abcdef"
  subnet_ids               = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
  control_plane_subnet_ids = ["subnet-xyzde987", "subnet-slkjf456", "subnet-qeiru789"]

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    example = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["m5.xlarge"]

      min_size     = 2
      max_size     = 10
      desired_size = 2
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
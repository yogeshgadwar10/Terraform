provider "aws" {
   region = "us-east-1"  
}
module "iam_role" {
  source = "./modules/iam_role"

  role_name           = "terraformP"
  assume_role_policy  = data.aws_iam_policy_document.assume_role.json
  policy_document     = data.aws_iam_policy_document.example.json
  create_policy       = true

  tags = {
    Environment = "dev"
    Owner       = "yogesh"
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "example" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = ["*"]
    effect    = "Allow"
  }
}
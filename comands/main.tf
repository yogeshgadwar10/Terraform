provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "my_instance" {
    ami = "ami-020cba7c55df1f615"
    key_name = "Yogesh-YG"
    vpc_security_group_ids = ["sg-09800eacd2c50e905"]
    instance_type = "t2.micro" 
}

resource "aws_security_group" "my_sg" {
  # (resource arguments)
}
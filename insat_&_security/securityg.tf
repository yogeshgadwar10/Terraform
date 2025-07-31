provider "aws" {
    region = var.region  
}
resource "aws_instance" "my_instance" {
    ami = var.image_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.my_security_group.id]

    tags = {
      env="dev"
    }  
}
resource "aws_security_group" "my_security_group" {
    # region = "us-east-2"     
    description = "new sg"
    name = "yogesh"
    ingress {
        protocol= "tcp"
        from_port= 80
        to_port= 80
        cidr_blocks= ["0.0.0.0/0"]
    }
    egress {
        protocol= "-1"
        from_port= 0
        to_port= 0
        cidr_blocks= ["0.0.0.0/0"]
    }
    tags = {
       env= "dev"
    }
    vpc_id = "vpc-0ba63bf8a7c370dfa"  
}
variable "region" {
    default = "us-east-1"
  
}
variable "image_id" {
    default = "ami-020cba7c55df1f615"  
}
variable "instance_type" {
    default = "t2.micro"
  
}

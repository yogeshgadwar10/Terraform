provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "my_instance" {
    ami = "ami-020cba7c55df1f615"
    vpc_security_group_ids = ["sg-09800eacd2c50e905"]
    
    count = 5   # create instance 5 times

    key_name = "Yogesh-YG"
    instance_type = "t2.micro"
}
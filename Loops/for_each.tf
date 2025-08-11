provider "aws" {
    region = "us-east-1"  
}
resource "aws_instance" "my_instance" {
    for_each = toset(var.ami_ids)
    ami = each.value
    instance_type = "t2.micro"  
}
variable "ami_ids" {
    default = ["ami-020cba7c55df1f615", "ami-084a7d336e816906b" , "ami-0ec18f6103c5e0491" ]
}

output "public_ip" {
    value =  [ for value in aws_instance.my_instance : value.public_ip ]
}


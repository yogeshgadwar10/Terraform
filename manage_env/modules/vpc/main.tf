resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.project}-vpc"
        env = var.env
    }  
}

resource "aws_subnet" "pri_sub" {
    cidr_block = var.pri_sub_cidr
    tags = {
      Name = "${var.project}-pri-subnet"
      env = var.env
    }
    vpc_id = aws_vpc.my_vpc.id 
}

resource "aws_subnet" "pri_sub_sub" {
    cidr_block = var.pub_sub_cidr
    tags = {
      Name = "${project}-pub-subnet"
      env = var.env
    }
    vpc_id = aws_vpc.my_vpc.id  
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = "${project}-igw"
    } 
}

resource "aws_default_route_table" "my_rt" {
    default_route_table_id = aws_vpc.my_vpc.default_route_table_id
    tags = {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.my_igw.id
    }  
}
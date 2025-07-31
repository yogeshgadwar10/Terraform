#template
variable "image_id" {
   default = "ami-020cba7c55df1f615"
}
variable "instance_type" {
    default =  "t2.micro" 
}
variable "security_group_ids" {
    default = ["sg-09800eacd2c50e905"] 
}
variable "key_pair" {
    default = "Yogesh-YG"  
}

variable "env" {
    default = "dev"  
}

#Autoscaling group
variable "min_size" {
    default = "2"  
}
variable "max_size" {
    default = "5"  
}

variable "desired_capacity" {
    default = "2"  
}
variable "availabity_zone" {
    default = ["us-east-1a", "us-east-1b"]      
}

#LB laod balancer
variable "vpc_id" {
    default = "vpc-0ba63bf8a7c370dfa"
}
variable "subnets" {
    default = ["subnet-0d546209428c15070", "subnet-0cbfea2df1f9e2a36", "subnet-0197b1cff4343ebc7"]
}
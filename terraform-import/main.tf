resource "aws_instance" "ec2-import" {
    subnet_id = "subnet-04a60e0083e0ef103"
    instance_type = "t3.micro"
    key_name = "public"
    ami = "ami-08f78cb3cc8a4578e"
    associate_public_ip_address = true
    availability_zone = "eu-north-1a"
    vpc_security_group_ids = ["sg-03a8cf4d4a1908df2"]
    tags = {
          Name = "ec2-for-terraform-import" 
        }   


  
}
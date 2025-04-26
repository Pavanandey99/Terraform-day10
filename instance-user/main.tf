resource "aws_instance" "ec2" {
    ami="ami-08f78cb3cc8a4578e"
    instance_type = "t3.micro"
    user_data = file("script.sh")
  
}
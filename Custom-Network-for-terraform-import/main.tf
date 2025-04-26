resource "aws_vpc" "VPC" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "New VPC"
    }
  
}

resource "aws_internet_gateway" "IG" {
    vpc_id = aws_vpc.VPC.id
    tags = {
      Name = "VPC-IG"
    }
  
}

resource "aws_subnet" "New-VPC-Subnet" {
    vpc_id = aws_vpc.VPC.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "New-VPC-Subnet"
    }
  
}

resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.VPC.id
    tags = {
        Name = "New-VPC-RT"
    }
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IG.id
    }
  
}

resource "aws_route_table_association" "RT-associations" {
    route_table_id = aws_route_table.RT.id
    subnet_id = aws_subnet.New-VPC-Subnet.id
  
}

resource "aws_security_group" "SG" {
    tags = {
        Name = "New-VPC-SG"
    }
    vpc_id = aws_vpc.VPC.id
    name = "allow"
    ingress {
        description = "TCP protocol for HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "TCP protocol for HTTP"
        from_port   = 20
        to_port     = 20
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
    
    
  
}

resource "aws_key_pair" "KP" {
    key_name = "public"
    public_key = file("~/.ssh/id_ed25519.pub")

}
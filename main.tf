#provider
#configure provider
#resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/guides/resource-tagging
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
  #profile = "Admin"
}


#vpc
# configure vpc
#resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "d5vpc" {
  cidr_block              = "10.0.0.0/16"
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "d5vpc"
  }
}


#configure subnets within vpc
#resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets
resource "aws_subnet" "d5pubsub1" {
  vpc_id                  = aws_vpc.d5vpc.id 
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "d5pubsub1"
  }
}

# Create a subnet within the VPC
resource "aws_subnet" "d5pubsub2" {
  vpc_id                  = aws_vpc.d5vpc.id 
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "d5pubsub2"
  }
}


#Jenkins Server
# resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "jenkins_server" {
  ami = "ami-053b0d53c279acc90"
  instance_type = "t2.medium"
  subnet_id = aws_subnet.d5pubsub1.id
  security_groups = [aws_security_group.jenkins_d5SG.id]
  key_name = var.key_name
  user_data = "${file("install_jenkins.sh")}"

  tags = {
    "Name" : "jenkins_server"
  }

}

# Application Server
# resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "application_server" {
  ami = "ami-053b0d53c279acc90"
  instance_type = "t2.medium"
  subnet_id = aws_subnet.d5pubsub2.id
  security_groups = [aws_security_group.application_d5SG.id]
  key_name = var.key_name

  user_data = "${file("install_dependencies.sh")}"

  tags = {
    "Name" : "application_server"
  }

}


#configure internet gateway
#resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "D5_igw" {
  vpc_id = aws_vpc.d5vpc.id

  tags = {
    Name = "D5_igw"
  }
}


#configure route table
#resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "D5_route_table" {
  vpc_id = aws_vpc.d5vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.D5_igw.id
  }

  tags = {
    Name = "D5_route_table"
  }
}


#security groups 22, 8080, 8000
resource "aws_security_group" "jenkins_d5SG" {
  name        = "jenkins_d5SG"
  description = "open ssh traffic"
  vpc_id = aws_vpc.d5vpc.id 


  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" : "jenkins_d5SG"
    "Terraform" : "true"
  }

}

#security groups 22, 8080, 8000
resource "aws_security_group" "application_d5SG" {
  name        = "app_d5SG"
  description = "open ssh traffic"
  vpc_id = aws_vpc.d5vpc.id 


  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" : "application_d5SG"
    "Terraform" : "true"
  }

}


# associate route table with subnets
resource "aws_route_table_association" "dp6_RT_pub1" {
  subnet_id      = aws_subnet.d5pubsub1.id
  route_table_id = aws_route_table.D5_route_table.id
}

resource "aws_route_table_association" "dp6_RT_pub2" {
  subnet_id      = aws_subnet.d5pubsub2.id
  route_table_id = aws_route_table.D5_route_table.id
}

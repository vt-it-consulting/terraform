
##################################################################################
# PROVIDERS
##################################################################################
provider "aws" {
  region = var.aws_region
}

##################################################################################
# DATA
##################################################################################

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}



##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = local.common_tags
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = local.common_tags
}

resource "aws_subnet" "subnet1" {
  cidr_block              = var.vpc_subnet1_cidr_block
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = local.common_tags
}

# ROUTING #
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = local.common_tags
}

resource "aws_route_table_association" "rta-subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rtb.id
}

# SECURITY GROUPS #
# Nginx security group 
resource "aws_security_group" "nginx-sg" {
  name   = "nginx_sg"
  vpc_id = aws_vpc.vpc.id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

# INSTANCES #
resource "aws_instance" "nginx1" {
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]

  user_data = <<EOF
#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Taco Team Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">You did it! Have a &#127790;</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF

  tags = local.common_tags

}



























































/*
# List
[1, 2, 3, 4]
["us-east-1", "us-east-2", "us-west-1", "us-west-2"]
[1, "us-east-2", true] # INVALID LIST!
# Map
{
small = "t2.micro"
medium = "t2.small"
large = "t2.large"
}
*/


#var.<name_label>[<element_number>]
#var.aws_regions[0]
variable "aws_regions" {
  type        = list(string)
  description = "Region to use for AWS resources"
  default     = ["us-east-1", "us-east-2", "us-west-1", "us-west-2"]
}


# var.<name_label>.<key_name> or var.<name_label>["key_name"]
# var.aws_instance_sizes.small or var.aws_instance_sizes["small"]
variable "aws_instance_sizes" {
  type        = map(string)
  description = "Region to use for AWS resources"
  default = {
    small  = "t2.micro"
    medium = "t2.small"
    large  = "t2.large"
  }
}

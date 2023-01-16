
provider "aws" {
    region = "eu-central-1"
}

variable "ingress_rules" {
    type = list(number)
    default = [80,443]
}

variable "egress_rules" {
    type = list(number)
    default = [80,443,25,3306,53,8080]
}

resource "aws_security_group" "webtraffic" {
    name = "Allow HTTPS"

    dynamic "ingress" {
        iterator = port 
        for_each = var.ingress_rules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }

    dynamic "egress" {
        iterator = port 
        for_each = var.egress_rules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }
}


resource "aws_instance" "ec2" {
    ami = "ami-032598fcc7e9d1c7a"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webtraffic.name]
}

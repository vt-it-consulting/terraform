

variable "aws_region" {
  type = string
  default = "eu-central-1"
}


variable "vpc_name" {
  type = string
  default = "my-new-vpc"
}

variable "ssh_port" {
  type = number
  default = 22
}

variable "enabled" {
  default = true
}

# for example for list of ip address
variable "myliste" {
  type = list(string)
  default = [ "Value1", "Value2", "Value3" ]

}

variable "my_map" {
  type = map
  default = {
    key1 = "Value1",
    key2 = "Value2"
  }
}


variable "input_name" {
  type = string
  description = "Set the name of the vpc"
}




provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = var.input_name
    }
}


# Details about the resource we have created!
output "my_output" {
  value = aws_vpc.myvpc.id
}


variable "mytuple" {
  type    = tuple([string, number, string])
  default = ["cat", 1, "dog"]
}

variable "myobject" {
  type = object({ name = string, port = list(number) })
  default = {
    name = "TJ"
    port = [22, 25, 80]
  }
}
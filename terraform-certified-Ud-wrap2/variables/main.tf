

variable "vpc_name" {
  type    = string
  default = "tf-course-my-vpc"
}

variable "port_number" {
  type    = number
  default = 22
}

variable "enable" {
  type    = bool
  default = true
}

variable "ips_liste" {
  type    = list(string)
  default = ["value 1", "value 2"]
}



variable "my_map" {
  type = map(any)
  default = {
    Name        = "My VPC",
    Environment = "Development"
  }
}




/*
variable "my_input_name" {
  type        = string
  description = "Set the name of the vpc"
}
*/


// How to use your variable
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  /*
   // Accessing variable string
  tags =  {
    Name = var.vpc_name 
  }

  // 
     tags = {
    Name = var.ips_liste[0]
   }
        tags = {
    Name = var.my_map["Name"]

// input variables
  tags = {
    Name = var.my_input_name
  }

   }
      */

  tags = {
    Name = var.my_map["Name"]
  }
}


output "my_output" {
  value = aws_vpc.my_vpc.id
}



variable "my_tuple" {
  type = tuple([string,number,string])
  default = ["cat", 10,"dog"]
}

output "print_the_names" {
  value = [for name in var.my_tuple : name]
}


variable "my_object" {
  type = object({name = string, port = list(number) })
  default = {
    name = "VT"
    port = [ 1,3,4,5,5 ]
  }
}
output "print_the_objects" {
  value = [for name in var.my_object : name]
}


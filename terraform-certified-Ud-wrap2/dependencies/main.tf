 

provider "aws" {
  region = "eu-central-1"
  profile = "default"
}

resource "aws_instance" "myec2" {
  ami           = "ami-03e08697c325f02ab"
  instance_type = "t2.micro"

  tags = {
    Name = "Web Server"
  }
  depends_on = [aws_instance.myec2db]
}

resource "aws_instance" "myec2db" {
  ami           = "ami-03e08697c325f02ab"
  instance_type = "t2.micro"

  tags = {
    Name = "DB Server"
  }
}

/*


data "aws_instance" "dbsearch" {
  filter {
    name   = "tag:Name"
    values = ["DB Server"]
  }
}

output "dbservers" {
  value = data.aws_instance.dbsearch.availability_zone
}

*/
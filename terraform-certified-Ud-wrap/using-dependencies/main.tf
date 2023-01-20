
provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "db" {
  ami           = "ami-0a261c0e5f51090b1"
  instance_type = "t2.micro"
}

resource "aws_instance" "web" {
  ami           = "ami-04a2b113b98bfa0e8"
  instance_type = "t2.micro"
  depends_on = [aws_instance.db]
}


# Use to query the provider data source

data "aws_instance" "dbsearch" {
  filter {
    name   = "image-id"
    values = ["ami-xxxxxxxx"]
  }

  filter {
    name   = "tag:Name"
    values = ["instance-name-tag"]
  }
}


output "dbservers" {
  value = data.aws_instance.dbsearch.availability_zone
}


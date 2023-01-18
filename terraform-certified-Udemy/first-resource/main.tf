provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
}

# setx = AWS_ACCESS_ID= "AKIA5QVX5EW337IBHHXE"
# setx = AWS_SECRET_KEY_ID= "2evRcQ08OH1Lpzjy+pnaCMM7JPYPlT6fvXwTAoU+"
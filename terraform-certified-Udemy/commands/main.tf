provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "myvpc2" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "vpc_tene_import" {
  
  cidr_block = "10.0.0.0/16"
}
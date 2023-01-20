variable "tags_ec2_instance" {
  type = map
  default = {
    "Environment" = "Developer"
    "Region" = "EU Central 1"
  }
}
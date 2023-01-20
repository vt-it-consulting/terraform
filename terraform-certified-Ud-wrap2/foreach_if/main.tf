



variable "user_names" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["user1", "user2", "user3"]
}

variable "iam_user_names" {
  description = "IAM usernames"
  type        = set(string)
  default     = ["user1", "user2", "user3s"]
} 


resource "aws_iam_user" "example1" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

resource "aws_iam_user" "example2" {
  for_each = var.iam_user_names
  name     = each.value
}

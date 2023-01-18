data "archive_file" "backup" {
  type        = "zip"
  source_file = "../data.txt"
  output_path = "${path.module}/archives/backup.zip"
}
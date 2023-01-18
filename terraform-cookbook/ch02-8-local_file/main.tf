resource "local_file" "myfile" {
  content  = "This is my text"
  filename = "../data.txt"
}

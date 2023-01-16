
resource "local_file" "pet" {
    filename = "./local_files/pets.txt"
    content = "we love pets!"
}
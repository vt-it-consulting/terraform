resource "local_file" "myfile" {
  content  = "This is my text"
  filename = "../data.txt"
}

resource "null_resource" "readcontentfile" {

  triggers = {
        trigger = timestamp()
  }

  provisioner "local-exec" {
    command = "Get-Content -Path ../data.txt" 

    interpreter = ["PowerShell", "-Command"]
  }
}
provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "terraform-ec2-instance" {
  ami           = "ami-0a709bebf4fa9246f"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}

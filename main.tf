provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "terraform-ec2-instance" {
  ami           = "ami-0310483fb2b488153" //Ubuntu AMI
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
                #! /bin/bash
                echo "Hello World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

    user_data_replace_on_change = true

  tags = {
    Name = "terraform-example"
  }
}


resource "aws_security_group" "instance" {
    name = "terraform-sg-httpd"

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

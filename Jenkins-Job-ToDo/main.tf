provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "jenkins_server" {
 ami = "ami-0767046d1677be5a0"
 instance_type = "t2.micro"
 key_name = "aws_key"
 vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
 tags = {
   Name = "Jenkins server from Terraform"
   Owner = "Andrii Hanzha"
 }
 user_data = file("JenkinsAndDockerInstall.sh")
}

resource "aws_instance" "prod_server" {
  ami = "ami-0767046d1677be5a0"
  instance_type = "t2.micro"
  key_name = "aws_key"
  vpc_security_group_ids = [aws_security_group.prod_sg.id]
  tags = {
    Name = "Production Server from Terraform"
    Owner = "Andrii Hanzha"
  }
  user_data = file("DockerInstall.sh") 
}


resource "aws_security_group" "jenkins_sg" {
    name = "jenkins_sg"
    description = "Security group allows port 8080 TCP for Jenkins"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "prod_sg" {
  name = "prod_sg"
  description = "Secutiry group allows port 3000 TCP for application"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

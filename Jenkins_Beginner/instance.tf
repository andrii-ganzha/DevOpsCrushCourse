provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "jenkins" {
 ami = "ami-0767046d1677be5a0"
 instance_type = "t2.micro"
 key_name = "aws_key"
 vpc_security_group_ids = [aws_security_group.my_webserver.id]
 tags = {
   Name = "Jenkins server"
   Owner = "Andrii"
 }
}

resource "aws_instance" "webserver1" {
 ami = "ami-0db9040eb3ab74509"
 instance_type = "t2.micro"
 key_name = "aws_key"
 vpc_security_group_ids = [aws_security_group.my_webserver.id]
 user_data = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform!" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF

tags = {
   Name = "TestDeploy webserver"
   Owner = "Andrii"
 }
}

resource "aws_instance" "webserver2" {
 ami = "ami-0db9040eb3ab74509"
 instance_type = "t2.micro"
 key_name = "aws_key"
 vpc_security_group_ids = [aws_security_group.my_webserver.id]
 user_data = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform!" > /var/www/html/index.html
sudo service httpd start                                                                                                chkconfig httpd on
EOF

tags = {
   Name = "ProdactionDeploy webserver"
   Owner = "Andrii"
 }
}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
   from_port   = 8080
   to_port     = 8080
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]

}

    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

 
tags = {
    Name = "Web Server SecurityGroup by Terraform"
    Owner = "Andrii Hanzha"
}
}


provider "aws" {
  access_key = "AKIAT7OVOOOFLPB3ON6W"
  secret_key = "oTyFCl1QA/mZj3da1uZ/WMYjTOqXCyfZ1igcDxQY"
  region = "eu-central-1"
}

resource "aws_instance" "sample" {
  count = 3
 ami = "ami-0767046d1677be5a0"
 instance_type = "t2.micro"
 tags = {
   Name = "My Ubuntu servers"
   Owner = "Andrii"
 }
}
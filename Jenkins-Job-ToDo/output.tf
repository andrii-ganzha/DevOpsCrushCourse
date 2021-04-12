output "jenkins_public_ip" {
  description = "Instance Public IP"
  value       = aws_instance.jenkins_server.public_ip
}

output "prod_public_ip" {
  description = "Instance Punlic IP"
  value       = aws_instance.prod_server.public_ip
}

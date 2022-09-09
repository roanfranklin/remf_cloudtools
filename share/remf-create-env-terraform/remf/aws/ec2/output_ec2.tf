
output "instance_{env_lower}_public_ip" {{
 value = aws_instance.project.public_ip
}}

output "instance_{env_lower}_public_dns" {{
  value = aws_instance.project.public_dns
}}

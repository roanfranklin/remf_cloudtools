
output "instance_{dev_lower}_public_ip" {{
 value = aws_instance.eip_instance.public_ip
}}

output "instance_{dev_lower}_public_dns" {{
  value = aws_instance.eip_instance.public_dns
}}

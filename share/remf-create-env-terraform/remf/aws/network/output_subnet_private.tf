
output "subnets_private_az_id{az}" {{
  value = aws_subnet.subnet_private_az.*.id[{index}]
}}

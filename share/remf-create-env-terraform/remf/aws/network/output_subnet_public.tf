
output "subnets_public_az_id{az}" {{
  value = aws_subnet.subnet_public_az.*.id[{index}]
}}

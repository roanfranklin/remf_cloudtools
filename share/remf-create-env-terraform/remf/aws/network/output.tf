output "vpc_env_id" {{
  value = aws_vpc.vpc_env.id
}}

output "subnets_private_az_id" {{
  value = aws_subnet.subnet_private_az.*.id
}}

output "subnets_public_az_id" {{
  value = aws_subnet.subnet_public_az.*.id
}}

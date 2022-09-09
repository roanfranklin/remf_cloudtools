resource "aws_nat_gateway" "nat_gateway_env" {{
  allocation_id = aws_eip.eip_env.id
  subnet_id     = aws_subnet.subnet_public_az.*.id[0]

  tags = {{
    Name = "{project}-nat-gateway-az1-{env_lower}"
  }}
}}
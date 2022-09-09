resource "aws_route_table" "rt_public_env" {{
  vpc_id = aws_vpc.vpc_env.id

  route {{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_env.id
  }}

  tags = {{
    Name = "{project}-rt-public-{env_lower}"
  }}
}}

resource "aws_route_table_association" "subnet-public-association-az" {{
  count = var.subnets_public_total

  subnet_id      = aws_subnet.subnet_public_az.*.id[count.index]
  route_table_id = aws_route_table.rt_public_env.id
}}



resource "aws_route_table" "rt_private_env" {{
  vpc_id = aws_vpc.vpc_env.id

  route {{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway_env.id
  }}

  tags = {{
    Name = "{project}-rt-private-{env_lower}"
  }}
}}

resource "aws_route_table_association" "subnet-private-association-az" {{
  count = var.subnets_private_total

  subnet_id      = aws_subnet.subnet_private_az.*.id[count.index]
  route_table_id = aws_route_table.rt_private_env.id
}}
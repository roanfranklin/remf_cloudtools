
resource "aws_subnet" "subnet_private_az" {{
  count = var.subnets_private_total

  vpc_id                  = aws_vpc.vpc_env.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet("${{var.cidr_env}}", 8, "${{count.index}}")
  map_public_ip_on_launch = false
  # ipv6_cidr_block = cidrsubnet(aws_vpc.vpc_env.ipv6_cidr_block, 8, 0)
  # assign_ipv6_address_on_creation = true
  tags = {tags_subnet_private}
}}


resource "aws_subnet" "subnet_public_az" {{
  count = var.subnets_public_total

  vpc_id                  = aws_vpc.vpc_env.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet("${{var.cidr_env}}", 8, "${{var.subnets_private_total + count.index}}")
  map_public_ip_on_launch = true
  # ipv6_cidr_block = cidrsubnet(aws_vpc.vpc_env.ipv6_cidr_block, 8, 1)
  # assign_ipv6_address_on_creation = true
  tags = {tags_subnet_public}
}}

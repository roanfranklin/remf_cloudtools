#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "project-eks-vpc" {{
  cidr_block = var.cidr_env

  tags = tomap({{
    "Name" = "{project}-eks-vpc"
    "kubernetes.io/cluster/{project}-eks-cluster" = "shared"
  }})
}}

resource "aws_subnet" "project-eks-subnet" {{
  count = var.subnets_public_total

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  #cidr_block              = cidrsubnet("${{var.cidr_env}}", 8, "${{var.subnets_public_total + var.subnets_private_total + count.index}}")
  cidr_block              = cidrsubnet("${{var.cidr_env}}", 8, "${{var.subnets_public_total + var.subnets_private_total + count.index}}")
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.project-eks-vpc.id

  tags = tomap({{
    "Name" = "{project}-eks-subnet"
    "kubernetes.io/cluster/{project}-eks-cluster" = "shared"
  }})
}}

resource "aws_internet_gateway" "project-eks-gateway" {{
  vpc_id = aws_vpc.project-eks-vpc.id

  tags = {{
    Name = "{project}-eks-gateway"
  }}
}}

resource "aws_route_table" "project-eks-route" {{
  vpc_id = aws_vpc.project-eks-vpc.id

  route {{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-eks-gateway.id
  }}
}}

resource "aws_route_table_association" "project-eks-route-table" {{
  count = var.subnets_public_total

  subnet_id      = aws_subnet.project-eks-subnet.*.id[count.index]
  route_table_id = aws_route_table.project-eks-route.id
}}
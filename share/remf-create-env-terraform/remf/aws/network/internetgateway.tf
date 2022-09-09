resource "aws_internet_gateway" "igw_env" {{
  vpc_id = aws_vpc.vpc_env.id
  
  tags = {{
    Name = "{project}-igw-{env_lower}"
  }}
}}
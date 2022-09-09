# ##############
# RDS MySQL

resource "aws_security_group" "env-rds-sg" {{
  name   = "sg_{env_lower}_rds_{engine}"
  vpc_id = var.vpc_env_id

  ingress {{
    protocol  = "tcp"
    from_port = {rds_port}
    to_port   = {rds_port}
    cidr_blocks = [
      var.vpc_env_cidr
      #"0.0.0.0/0"
    ]
  }}
{list_ingress}
  egress {{
    protocol         = -1
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }}
}}
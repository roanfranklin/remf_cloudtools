resource "aws_security_group" "project_sg" {{
  name   = "sg_{env_lower}_ec2_project"
  vpc_id = var.vpc_env_id

  ingress {{
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = var.ssh_port
    to_port   = var.ssh_port
    protocol  = "tcp"
  }}
{list_ingress}
  egress {{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }}
}}
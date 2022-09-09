  
  ingress {{
    cidr_blocks = [
      var.vpc_env_cidr,
      "{ipv4}"
    ]
    description = "{description}"
    from_port = {port}
    to_port   = {port}
    protocol  = "{protocol}"
  }}
  
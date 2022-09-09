resource "aws_eip" "eip-instance" {{
  instance = aws_instance.project.id
  vpc      = true

  tags = {{
    Name = "{project}-{ec2_name}-eip-ec2-{env_lower}"
  }}
}}
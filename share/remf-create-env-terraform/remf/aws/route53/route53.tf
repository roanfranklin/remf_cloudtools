resource "aws_route53_zone" "main_domain" {{
  name         = var.domain
  tags         = {{
    Name = "{project}-route53-${{var.environment}}"
  }}
}}

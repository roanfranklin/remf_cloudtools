output "name_servers_domain" {{
  value = aws_route53_zone.main_domain.name_servers
}}
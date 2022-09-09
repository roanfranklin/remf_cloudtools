
resource "aws_route53_record" "{record_name}" {{
  zone_id = aws_route53_zone.main_domain.zone_id
  name    = "{record_name}.${{var.domain}}"
  type    = "CNAME"
  ttl     = 60
  records = {records}
}}

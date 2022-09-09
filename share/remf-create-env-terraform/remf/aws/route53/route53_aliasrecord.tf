
resource "aws_route53_record" "{record_name}" {{
  zone_id    = aws_route53_zone.main_domain.zone_id
  name       = "{record_name}.${{var.domain}}"
  type       = "A"
  alias {{
    name                   = "{alias_name}"
    zone_id                = "{alias_zone_id}"
    evaluate_target_health = {alias_evaluate_target_health}
  }}
}}

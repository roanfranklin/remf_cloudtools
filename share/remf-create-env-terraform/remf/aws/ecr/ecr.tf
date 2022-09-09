resource "aws_ecr_repository" "repository_{name}" {{
  name                 = "{name}"
  image_tag_mutability = "{image_tag_mutability}"

  image_scanning_configuration {{
    scan_on_push = {image_scan_on_push}
  }}
}}


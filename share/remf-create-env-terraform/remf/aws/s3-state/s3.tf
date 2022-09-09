# Bucket S3
resource "aws_s3_bucket" "project-terraform-state" {{
  bucket = "{project}-terraform-state"

  # Seta nome e ambiente deste bucket
  tags = {{
    Name        = "{project}-terraform-state"
    Environment = "all"
  }}

  # Habilite o controle de versão para que possamos ver o histórico de revisão completo de nosso
  # arquivos de estado
  versioning {{
    enabled = true
  }}

  # Ative a criptografia do lado do servidor por padrão
  server_side_encryption_configuration {{
    rule {{
      apply_server_side_encryption_by_default {{
        sse_algorithm = "AES256"
      }}
    }}
  }}
}}

# seta permissão de privado para o bucket
resource "aws_s3_bucket_public_access_block" "project-terraform-state" {{
  bucket = aws_s3_bucket.project-terraform-state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}}
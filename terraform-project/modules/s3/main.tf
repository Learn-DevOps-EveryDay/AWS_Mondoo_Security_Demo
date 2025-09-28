variable "bucket_name" {
  type = string
}
variable "tags" {
  type = map(string)
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags   = merge(var.tags, { Name = var.bucket_name })
}

output "bucket_id" {
  value = aws_s3_bucket.this.id
}

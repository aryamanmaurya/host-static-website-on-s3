#provider 
provider "aws" {
  region = var.region
}

#creating bucket 
resource "aws_s3_bucket" "create-bucket" {
  bucket = var.bucket
  
}

#bucket ownership control
resource "aws_s3_bucket_ownership_controls" "ownership-control" {
  bucket = aws_s3_bucket.create-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


#bucket acl for public read 
resource "aws_s3_bucket_acl" "bucket-acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ownership-control,
    aws_s3_bucket_public_access_block.public_access,
  ]

  bucket = aws_s3_bucket.create-bucket.id
  acl    = "public-read"
}


#enable public access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.create-bucket.id

  block_public_acls   = false
  block_public_policy = false
  ignore_public_acls  = false
  restrict_public_buckets = false
}


#s3 bucket versioning configuration
resource "aws_s3_bucket_versioning" "bucket-versioning" {
  bucket = aws_s3_bucket.create-bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}


#bucket policy for public read only
resource "aws_s3_bucket_policy" "read-only-policy" {
  depends_on = [
    aws_s3_bucket_acl.bucket-acl,
    aws_s3_bucket_public_access_block.public_access
  ]
  bucket = aws_s3_bucket.create-bucket.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.create-bucket.bucket}/*"
    }
  ]
}
POLICY
}

# s3 bucket website configuration
resource "aws_s3_bucket_website_configuration" "static-website" {
  bucket = aws_s3_bucket.create-bucket.id

  index_document {
    suffix = "index.html"
  }
}

#uploading website files
#html file
resource "aws_s3_object" "uploading-file1" {
  bucket = aws_s3_bucket.create-bucket.bucket

  key = "index.html"
  source = "./index.html"
  content_type = "text/html"
}

#styles.css file
resource "aws_s3_object" "uploading-file2" {
bucket = aws_s3_bucket.create-bucket.bucket

key = "styles.css"
source = "./styles.css"
content_type = "text/css"
}

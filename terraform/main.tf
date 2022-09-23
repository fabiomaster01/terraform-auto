terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      Version = "~>3.27"
    }
  }

  required_version = ">=0.14.9" 

   backend "s3" {
       bucket = "fm-terratest2"
       key    = "terraform-state/"
       region = "east-us-1"
   }

}

provider "aws" {
  version = "~>3.0"
  region  = "east-us-1"
}

resource "aws_s3_bucket" "s3Bucket" {
     bucket = "fm-terratest2"
     acl       = "public-read"

     policy  = <<EOF
{
     "id" : "MakePublic",
   "version" : "2012-10-17",
   "statement" : [
      {
         "action" : [
             "s3:GetObject"
          ],
         "effect" : "Allow",
         "resource" : "arn:aws:s3:::fm-terratest2*",
         "principal" : "*"
      }
    ]
  }
EOF

   website {
       index_document = "index.html"
   }
}
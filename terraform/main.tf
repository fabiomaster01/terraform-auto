terraform {
    required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 4.0"
    }
  }



   backend "s3" {
       bucket = "fm-terra-state"
       key    = "terraform-state"
       region = "us-east-1"
   }

}

provider "aws" {
  #version = "~>3.0"
  region  = "us-east-1"
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
         "resource" : ["arn:aws:s3:::fm-terratest2/*","arn:aws:s3:::fm-terratest2"],
         "principal" : "*"
      }
    ]
  }
EOF

   website {
       index_document = "index.html"
   }
}
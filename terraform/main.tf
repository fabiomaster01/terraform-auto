terraform {
   
   backend "s3" {
       bucket = "fm-terratest2"
       key    = "terraform-state/"
       region = "east-us-1"
   }

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
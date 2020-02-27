# variables for AWS simple-infrastrure #

variable AWS_ACCESS_KEY {
 type        = string
 description = "Enter your IAM user user access key and make sure IAM user has administrator access"
}

variable AWS_SECRET_KEY {
 type        = string
 description = "Enter your IAM user user secret key and make sure IAM user  has administrator access"
}

variable AWS_REGION {
 type        = string
 description = "Enter the required region for your VPC"
}

variable AWS_ZONE1 {
 type        = string
 description = "Enter one availability zone which should be in the same region specified above"
}

variable AWS_ZONE2 {
 type        = string
 description = "Enter other availability zone which should be in the same region specified above"
}


variable AMIS {
   type        = string
   description = "Please enter the name of AMI which is in the same region and should unsubscribed one"
}

variable "PRIVATE_KEY" {
  default = "mykey"
}

variable "PUBLIC_KEY" {
  default = "mykey.pub"
}

# varibles for DB 

variable "db_username" {
 type        = string
 description = "Please enter a username for RDS instance database"
}
variable "db_password" {
 type        = string
 description = "Please enter a password for database user. Password must contains letters and numbers and password length should be above 8 characters"
}

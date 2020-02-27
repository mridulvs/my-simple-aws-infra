output "db_ENDPOINT" {
 description = " please use this ARN value to connect the RDS from EC2 instance" 
 value = aws_db_instance.RDS_instance.address
}
output "db_username" {
 description = " please use this database username to connect RDS instance database from EC2 instance" 
 value = aws_db_instance.RDS_instance.username
}
output "db_password" {
 description = " please use this database user password to connect RDS instance database from EC2 instance" 
 value = aws_db_instance.RDS_instance.password
}

output "ec2_associated_EIP" {
 description = " please use this public IP to connect the EC2 instance using mykey"
 value = aws_eip.my-eib.public_ip
}

# Creating key for access Ec2 instance

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.PUBLIC_KEY)
}

# create ec2 instance (CentOS 7) under public subnet

resource "aws_instance" "web-server" {
  ami                         = var.AMIS
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.mykey.key_name
  subnet_id                   = aws_subnet.internet_subnet.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  root_block_device {
    volume_type = "gp2"
    volume_size = 20
  }
  tags = {
    Name = "Web Server"

  }
}

# Create RDS instance with mysql under private subnet and setup admin password

resource "aws_db_instance" "RDS_instance" {
  identifier             = "my-rds"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "mydb"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.RDS_subnet_group.id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true  
  ca_cert_identifier        = "rds-ca-2019"
}


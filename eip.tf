# EIP 

resource "aws_eip" "my-eib" {
  vpc      = true
}

#EIP association

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web-server.id
  allocation_id = aws_eip.my-eib.id
}


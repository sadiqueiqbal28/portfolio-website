resource "aws_key_pair" "bastion_key" {
  key_name   = var.bastion_key_name
  public_key = file(var.bastion_public_key)
}

resource "aws_security_group" "bastion_sg" {
  vpc_id      = aws_vpc.prod_vpc.id
  name        = var.bastion_sg_name
  description = "Allows traffic for Bastion server"

  dynamic "ingress" {
    for_each = toset(var.bastion_ports)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.Environments}/Bastion-Security-Group"
  }

}

resource "aws_instance" "bastion_server" {
  instance_type   = var.bastion_instance_type
  ami             = var.ami
  key_name        = aws_key_pair.bastion_key.key_name
  subnet_id       = aws_subnet.public_subnet_1b.id
  security_groups = [aws_security_group.bastion_sg.id]
  root_block_device {
    volume_size = var.bastion_ebs_volume
    volume_type = "gp3"
  }
  tags = {
    Name = "${var.Environments}Bastion Server"
  }
}
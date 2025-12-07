resource "aws_key_pair" "jenkins_key" {
  key_name   = var.jenkins_key_name
  public_key = file(var.jenkins_public_key)
}

resource "aws_security_group" "jenkins_sg" {
  vpc_id      = aws_vpc.prod_vpc.id
  name        = "jenkins-security-group"
  description = "Allows ports for Jenkins Server"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Jenkins-Security-Group"
  }
}

resource "aws_instance" "jenkins_server" {
  instance_type   = "t2.medium"
  ami             = var.ami
  key_name        = aws_key_pair.jenkins_key.key_name
  subnet_id       = aws_subnet.public_subnet_1a.id
  security_groups = [aws_security_group.jenkins_sg.id]
  user_data       = file("install_jenkins.sh")
  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }
  tags = {
    Name = "Jenkins Server"
  }
}
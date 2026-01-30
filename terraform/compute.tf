
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "nginx" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  key_name               = aws_key_pair.ssh.key_name
  vpc_security_group_ids = [aws_security_group.nginx.id]

  tags = { Name = "nginx-lb" }
}

resource "aws_instance" "control_plane" {
  count                  = 3
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.medium"
  subnet_id              = aws_subnet.private.id
  key_name               = aws_key_pair.ssh.key_name
  vpc_security_group_ids = [aws_security_group.private.id]

  tags = { Name = "control-plane-${count.index + 1}" }
}

resource "aws_instance" "worker" {
  count                  = 1
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.medium"
  subnet_id              = aws_subnet.private.id
  key_name               = aws_key_pair.ssh.key_name
  vpc_security_group_ids = [aws_security_group.private.id]

  tags = { Name = "worker-${count.index + 1}" }
}

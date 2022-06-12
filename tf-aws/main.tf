provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.subnet[0]
  tags = {
    Name = "tf_default_vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.subnet[1]
  availability_zone = "us-east-1a"
  tags = {
    Name = "tf_subnet"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "tf_igw"
  }
}

resource "aws_security_group" "sg" {
  name = "my_sg"
  vpc_id = aws_vpc.my_vpc.id
  dynamic "ingress" {
    iterator = port #according what to make the iterastions
    for_each = var.ports
    content {
    from_port        = port.value
    to_port          = port.value
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "tf_sg"
  }
}

resource "aws_route_table" "route_table_tf" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    NSame = "tf_route_table"
  }
}

resource "aws_route_table_association" "route_assocation_id" {
  subnet_id = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.route_table_tf.id
}

resource "aws_instance" "jenkins" {
  ami = var.ami
  instance_type = var.instance_type[0]
  key_name = "sahar"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id = aws_subnet.my_subnet.id
  user_data = file("./jenkins.sh")
  tags = {
    Name = "Jenkins-server"
  }
}

resource "aws_eip" "eip_jenkins" {
  instance = aws_instance.jenkins.id
}

resource "aws_instance" "ansible_master" {
  ami = var.ami
  instance_type = var.instance_type[0]
  key_name = "sahar"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id = aws_subnet.my_subnet.id
  user_data = file("./ansible_master.sh")
  tags = {
    Name = "Ansible-ControlNode"
  }
}

resource "aws_eip" "eip_ansible" {
  instance = aws_instance.ansible_master.id
}

resource "aws_instance" "ansible_node1" {
  ami = var.ami
  instance_type = var.instance_type[0]
  key_name = "sahar"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id = aws_subnet.my_subnet.id
  user_data = file("./ansible_node.sh")
  tags = {
    Name = "AnsibleMN-Apache-Tomcat"
  }
}

resource "aws_eip" "ansible_node1" {
  instance = aws_instance.ansible_node1.id
}


resource "aws_instance" "docker" {
  ami = var.ami
  instance_type = var.instance_type[0]
  key_name = "sahar"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id = aws_subnet.my_subnet.id
  user_data = file("./docker.sh")
  tags = {
    Name = "AnsibleMN-DockerHost"
  }
}

resource "aws_eip" "docker" {
  instance = aws_instance.docker.id
}


resource "aws_instance" "nexus" {
  ami = var.ami
  instance_type = var.instance_type[1]
  key_name = "sahar"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id = aws_subnet.my_subnet.id
  user_data = file("./nexus.sh")
  tags = {
    Name = "Nexus-Server"
  }
}

resource "aws_eip" "nexus" {
  instance = aws_instance.nexus.id
}
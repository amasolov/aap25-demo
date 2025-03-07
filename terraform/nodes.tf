resource "aws_instance" "aap25-demo-installer" {
  ami                    = local.aws_installer_ami
  instance_type          = local.aws_installer_type

  subnet_id              = aws_subnet.aap25-demo-subnet.id
  key_name               = aws_key_pair.aap25-demo-login-key.key_name
  vpc_security_group_ids = [aws_security_group.aap25-demo-main.id]
  associate_public_ip_address = "true"

  user_data              = file("resources/user-data-node-RHEL9.sh")

  provisioner "file" {
    source      = "/Users/amasolov/.ssh/id_rsa"
    destination = "/home/ec2-user/.ssh/id_rsa"
    connection {
      type        = local.connection["type"]
      user        = local.connection["user"]
      private_key = local.connection["private_key"]
      host        = self.public_ip
    }
  }

  provisioner "file" {
    content = templatefile("resources/inventory.tpl.yaml", {
      redhat_username = local.redhat_username,
      redhat_password = local.redhat_password,
      cluster_domain  = local.cluster_domain,
      cluster_password = local.cluster_password
    })
    destination = "/home/ec2-user/inventory.yaml"
    connection {
      type        = local.connection["type"]
      user        = local.connection["user"]
      private_key = local.connection["private_key"]
      host        = self.public_ip
    }
  }

  root_block_device {
    volume_size = 30
  }

  tags = {
    Name = "${ local.cluster_name }-installer"
  }
}

resource "ansible_host" "aap25-demo-installer" {
  name   = aws_instance.aap25-demo-installer.public_dns
  groups = ["installer"]
  variables = {
    ansible_user                 = "ec2-user",
    ansible_ssh_private_key_file = "/Users/amasolov/.ssh/id_rsa",
    ansible_ssh_extra_args       = " -o StrictHostKeyChecking=no ",
    cluster_hostname             = "installer.${ local.cluster_domain }",
    cluster_private_ip           = aws_instance.aap25-demo-installer.private_ip,
    cluster_public_ip            = aws_instance.aap25-demo-installer.public_ip,
  }
}

resource "aws_instance" "automationgateway-0" {
  ami                    = "ami-018e625a2beb97a6a"
  instance_type          = "m5.xlarge"
  subnet_id              = aws_subnet.aap25-demo-subnet.id
  key_name               = aws_key_pair.aap25-demo-login-key.key_name
  vpc_security_group_ids = [aws_security_group.aap25-demo-main.id]
  user_data              = file("resources/user-data-node-RHEL9.sh")
  associate_public_ip_address = "true"
  root_block_device {
    volume_size = 60
  }
  tags = {
    Name = "${ local.cluster_name }-automationgateway-0"
  }
}

resource "ansible_host" "automationgateway-0" {
  name   = aws_instance.automationgateway-0.public_dns
  groups = ["automationgateway"]
  variables = {
    ansible_user                 = "ec2-user",
    ansible_ssh_private_key_file = "/Users/amasolov/.ssh/id_rsa",
    ansible_ssh_extra_args       = " -o StrictHostKeyChecking=no ",
    cluster_hostname             = "automationgateway-0.${ local.cluster_domain }",
    cluster_private_ip           = aws_instance.automationgateway-0.private_ip,
    cluster_public_ip            = aws_instance.automationgateway-0.public_ip,
  }
}

resource "aws_instance" "automationcontroller-0" {
  ami                    = "ami-018e625a2beb97a6a"
  instance_type          = "m5.xlarge"
  subnet_id              = aws_subnet.aap25-demo-subnet.id
  key_name               = aws_key_pair.aap25-demo-login-key.key_name
  vpc_security_group_ids = [aws_security_group.aap25-demo-main.id]
  user_data              = file("resources/user-data-node-RHEL9.sh")
  associate_public_ip_address = "true"
  root_block_device {
    volume_size = 60
  }
  tags = {
    Name = "${ local.cluster_name }-automationcontroller-0"
  }
}

resource "ansible_host" "automationcontroller-0" {
  name   = aws_instance.automationcontroller-0.public_dns
  groups = ["automationcontroller"]
  variables = {
    ansible_user                 = "ec2-user",
    ansible_ssh_private_key_file = "/Users/amasolov/.ssh/id_rsa",
    ansible_ssh_extra_args       = " -o StrictHostKeyChecking=no ",
    cluster_hostname             = "automationcontroller-0.${ local.cluster_domain }",
    cluster_private_ip           = aws_instance.automationcontroller-0.private_ip,
    cluster_public_ip            = aws_instance.automationcontroller-0.public_ip,
  }
}

resource "aws_instance" "automationhub-0" {
  ami                    = "ami-018e625a2beb97a6a"
  instance_type          = "m5.xlarge"
  subnet_id              = aws_subnet.aap25-demo-subnet.id
  key_name               = aws_key_pair.aap25-demo-login-key.key_name
  vpc_security_group_ids = [aws_security_group.aap25-demo-main.id]
  user_data              = file("resources/user-data-node-RHEL9.sh")
  associate_public_ip_address = "true"
  root_block_device {
    volume_size = 60
  }
  tags = {
    Name = "${ local.cluster_name }-automationhub-0"
  }
}

resource "ansible_host" "automationhub-0" {
  name   = aws_instance.automationhub-0.public_dns
  groups = ["automationhub"]
  variables = {
    ansible_user                 = "ec2-user",
    ansible_ssh_private_key_file = "/Users/amasolov/.ssh/id_rsa",
    ansible_ssh_extra_args       = " -o StrictHostKeyChecking=no ",
    cluster_hostname             = "automationhub-0.${ local.cluster_domain }",
    cluster_private_ip           = aws_instance.automationhub-0.private_ip,
    cluster_public_ip            = aws_instance.automationhub-0.public_ip,
  }
}

resource "aws_instance" "automationedacontroller-0" {
  ami                    = "ami-018e625a2beb97a6a"
  instance_type          = "m5.xlarge"
  subnet_id              = aws_subnet.aap25-demo-subnet.id
  key_name               = aws_key_pair.aap25-demo-login-key.key_name
  vpc_security_group_ids = [aws_security_group.aap25-demo-main.id]
  user_data              = file("resources/user-data-node-RHEL9.sh")
  associate_public_ip_address = "true"
  root_block_device {
    volume_size = 60
  }
  tags = {
    Name = "${ local.cluster_name }-automationedacontroller-0"
  }
}

resource "ansible_host" "automationedacontroller-0" {
  name   = aws_instance.automationedacontroller-0.public_dns
  groups = ["automationedacontroller"]
  variables = {
    ansible_user                 = "ec2-user",
    ansible_ssh_private_key_file = "/Users/amasolov/.ssh/id_rsa",
    ansible_ssh_extra_args       = " -o StrictHostKeyChecking=no ",
    cluster_hostname             = "automationedacontroller-0.${ local.cluster_domain }",
    cluster_private_ip           = aws_instance.automationedacontroller-0.private_ip,
    cluster_public_ip            = aws_instance.automationedacontroller-0.public_ip,
  }
}

resource "aws_instance" "executionnode-0" {
  ami                    = "ami-018e625a2beb97a6a"
  instance_type          = "m5.xlarge"
  subnet_id              = aws_subnet.aap25-demo-subnet.id
  key_name               = aws_key_pair.aap25-demo-login-key.key_name
  vpc_security_group_ids = [aws_security_group.aap25-demo-main.id]
  user_data              = file("resources/user-data-node-RHEL9.sh")
  associate_public_ip_address = "true"
  root_block_device {
    volume_size = 60
  }
  tags = {
    Name = "${ local.cluster_name }-executionnode-0"
  }
}

resource "ansible_host" "executionnode-0" {
  name   = aws_instance.executionnode-0.public_dns
  groups = ["execution_nodes"]
  variables = {
    ansible_user                 = "ec2-user",
    ansible_ssh_private_key_file = "/Users/amasolov/.ssh/id_rsa",
    ansible_ssh_extra_args       = " -o StrictHostKeyChecking=no ",
    cluster_hostname             = "executionnode-0.${ local.cluster_domain }",
    cluster_private_ip           = aws_instance.executionnode-0.private_ip,
    cluster_public_ip            = aws_instance.executionnode-0.public_ip,
  }
}

resource "aws_instance" "database-0" {
  ami                    = "ami-018e625a2beb97a6a"
  instance_type          = "m5.xlarge"
  subnet_id              = aws_subnet.aap25-demo-subnet.id
  key_name               = aws_key_pair.aap25-demo-login-key.key_name
  vpc_security_group_ids = [aws_security_group.aap25-demo-main.id]
  user_data              = file("resources/user-data-node-RHEL9.sh")
  associate_public_ip_address = "true"
  root_block_device {
    volume_size = 60
  }
  tags = {
    Name = "${ local.cluster_name }-database-0"
  }
}

resource "ansible_host" "database-0" {
  name   = aws_instance.database-0.public_dns
  groups = ["database"]
  variables = {
    ansible_user                 = "ec2-user",
    ansible_ssh_private_key_file = "/Users/amasolov/.ssh/id_rsa",
    ansible_ssh_extra_args       = " -o StrictHostKeyChecking=no ",
    cluster_hostname             = "database-0.${ local.cluster_domain }",
    cluster_private_ip           = aws_instance.database-0.private_ip,
    cluster_public_ip            = aws_instance.database-0.public_ip,
  }
}

resource "aws_instance" "client-0" {
  ami                    = "ami-018e625a2beb97a6a"
  instance_type          = "m5.xlarge"
  subnet_id              = aws_subnet.aap25-demo-subnet.id
  key_name               = aws_key_pair.aap25-demo-login-key.key_name
  vpc_security_group_ids = [aws_security_group.aap25-demo-main.id]
  user_data              = file("resources/user-data-node-RHEL9.sh")
  associate_public_ip_address = "true"
  root_block_device {
    volume_size = 60
  }
  tags = {
    Name = "${ local.cluster_name }-client-0"
  }
}

resource "ansible_host" "client-0" {
  name   = aws_instance.client-0.public_dns
  groups = ["client"]
  variables = {
    ansible_user                 = "ec2-user",
    ansible_ssh_private_key_file = "/Users/amasolov/.ssh/id_rsa",
    ansible_ssh_extra_args       = " -o StrictHostKeyChecking=no ",
    cluster_hostname             = "client-0.${ local.cluster_domain }",
    cluster_private_ip           = aws_instance.client-0.private_ip,
    cluster_public_ip            = aws_instance.client-0.public_ip,
  }
}



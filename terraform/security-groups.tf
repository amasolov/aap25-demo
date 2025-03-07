resource "aws_security_group" "aap25-demo-installer" {

  name        = "${ local.cluster_name }-installer"
  description = "${ local.cluster_name }-installer Created by Terraform"

  vpc_id = aws_vpc.aap25-demo-main.id

  // Allow SSH Access from personal IP
  ingress {
    description = "Personal SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${ local.allowed_ip }/32"]
  }

  # Allow all ingress traffic internally
  ingress {
    description = "All ingress traffic internally"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    self        = true
  }

  # All egress allowed
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${ local.cluster_name }-installer"
  }

}

resource "aws_security_group" "aap25-demo-main" {

  name        = "${ local.cluster_name }-main"
  description = "${ local.cluster_name }-main Created by Terraform"

  vpc_id = aws_vpc.aap25-demo-main.id

  // Note: can be disabled after install (need to be open for maintenance)
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.aap25-demo-installer.id]
  }

  // Note: allowed from personal IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${ local.allowed_ip }/32"]
  }

  // Note: for UI access from personal IP
  ingress {
    description = "HTTPS Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${ local.allowed_ip }/32"]
  }

  # Allow all ingress traffic internally
  ingress {
    description = "All ingress traffic internally"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    self        = true
  }

  # All egress allowed
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${ local.cluster_name }-main"
  }

}

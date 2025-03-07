terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    sops = {
      source  = "nobbs/sops"
      version = "~> 0.1.0"
    }
    ansible = {
      source = "ansible/ansible"
      version = "~> 1.3.0"
    }
  }
}

resource "aws_vpc" "aap25-demo-main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "${ local.cluster_name }-main"
  }
}

resource "aws_key_pair" "aap25-demo-login-key" {
  key_name   = "${ local.cluster_name }-login-key-01"
  public_key = "${ local.connection.public_key }"
  tags = {
    Name = "${ local.cluster_name }-login-key"
  }
}

resource "aws_subnet" "aap25-demo-subnet" {
  vpc_id            = aws_vpc.aap25-demo-main.id
  cidr_block        = cidrsubnet(aws_vpc.aap25-demo-main.cidr_block, 8, 1)
  tags = {
    Name = "${ local.cluster_name }-subnet"
  }
}

resource "aws_internet_gateway" "aap25-demo-gw" {
  vpc_id = aws_vpc.aap25-demo-main.id
  tags = {
    Name = "${ local.cluster_name }-gw"
  }
}

resource "aws_route_table" "aap25-demo-main-rt" {
  vpc_id = aws_vpc.aap25-demo-main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aap25-demo-gw.id
  }
  tags = {
    Name = "${ local.cluster_name }-main-rt"
  }

}

resource "aws_route_table_association" "aap25-demo-public-association" {
 subnet_id      = aws_subnet.aap25-demo-subnet.id
 route_table_id = aws_route_table.aap25-demo-main-rt.id
}

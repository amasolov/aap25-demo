locals {
  cluster_name = "aap25-demo"
  cluster_domain = "example.com"
  cluster_password = provider::sops::file("../secrets/secrets.sops.yaml").data["cluster_password"]
  allowed_ip = provider::sops::file("../secrets/secrets.sops.yaml").data["allowed_ip"]

  aws_region = "ap-southeast-2"
  aws_profile = "redhat-temp"
  aws_installer_ami = "ami-018e625a2beb97a6a"
  aws_installer_type = "m5.xlarge"
  aws_platform_ami = "ami-018e625a2beb97a6a"
  aws_platform_type = "m5.xlarge"
  aws_client_ami = "ami-018e625a2beb97a6a"
  aws_client_type = "m5.xlarge"

  connection = {
    type        = "ssh"
    user        = "ec2-user"
    private_key = provider::sops::file("../secrets/secrets.sops.yaml").data["ssh_private_key"]
    public_key = provider::sops::file("../secrets/secrets.sops.yaml").data["ssh_public_key"]
  }

  redhat_username = provider::sops::file("../secrets/secrets.sops.yaml").data["redhat_username"]
  redhat_password = provider::sops::file("../secrets/secrets.sops.yaml").data["redhat_password"]
}


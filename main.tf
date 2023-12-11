provider "aws" {
  region  = var.region
}

module "vpc" {
  source            = "git::https://github.com/rogerio-calixto/aws-network-template.git"
  aws_region        = var.region
  project           = local.project
  environment       = local.environment
  cidr_block        = local.cidr_block
  subnet_pvt_config = local.subnet_pvt_config
  subnet_pub_config = local.subnet_pub_config
}

module "instance" {
  source              = "git::https://github.com/rogerio-calixto/aws-instance-template.git"
  region              = var.region
  project             = local.project
  environment         = local.environment
  ami                 = lookup(var.ubuntu-amis, var.region)
  instance-type       = "t3.micro"
  keypair-name        = lookup(var.region-keypair, var.region)
  vpc-id              = module.vpc.aws_vpc_id
  subnet-id           = module.vpc.public-subnet_ids[0]
  sg-id               = aws_security_group.sg-host.id
  associate-public-ip = true
  instance-name       = "${local.project}-server"
}

resource "aws_security_group" "sg-host" {
  name        = "${local.project}-sg-host"
  description = "Habilita acesso ao bastion host"
  vpc_id      = module.vpc.aws_vpc_id

  ingress {
    description     = "libera SSH para instance ip particular"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["179.125.170.200/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${local.project}-sg-calixto"
    Project     = local.project
    Environment = local.environment
  }

  depends_on = [ module.vpc ]
}
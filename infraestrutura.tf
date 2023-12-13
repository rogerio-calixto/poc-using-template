module "vpc" {
  source                = "git::https://github.com/rogerio-calixto/aws-network-template.git"
  aws_profile           = var.aws_profile
  aws_access_key        = var.access_key
  aws_access_secret_key = var.secret_key
  aws_region            = var.aws_region
  environment           = var.environment
  project               = local.project
  cidr_block            = local.cidr_block
  subnet_pvt_config     = local.subnet_pvt_config
  subnet_pub_config     = local.subnet_pub_config
}

module "instance" {
  source                = "git::https://github.com/rogerio-calixto/aws-instance-template.git"
  aws_profile           = var.aws_profile
  aws_access_key        = var.access_key
  aws_access_secret_key = var.secret_key
  aws_region            = var.aws_region
  environment           = var.environment
  project               = local.project
  ami                   = lookup(var.ubuntu-amis, var.aws_region)
  instance-type         = var.instance-type
  keypair-name          = lookup(var.region-keypair, var.aws_region)
  vpc-id                = module.vpc.aws_vpc_id
  subnet-id             = module.vpc.public-subnet_ids[0]
  sg-id                 = aws_security_group.sg-host.id
  associate-public-ip   = true
  instance-name         = "${local.project}-server"
}

resource "aws_security_group" "sg-host" {
  name        = "${local.project}-sg-host"
  description = "Habilita acesso ao bastion host"
  vpc_id      = module.vpc.aws_vpc_id

  ingress {
    description = "libera SSH para instance ip particular"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
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
    Environment = var.environment
    Project     = local.project
  }
}
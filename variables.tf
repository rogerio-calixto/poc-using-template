variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "aws_profile" {
  type        = any
  description = "AWS profile"
  default     = null
}

variable "access_key" {
  type        = any
  description = "AWS profile"
  default     = null
}

variable "secret_key" {
  type        = any
  description = "AWS profile"
  default     = null
}

variable "environment" {
  type        = string
  description = "environment"
}

variable "instance-type" {
  type        = string
  description = "instance-type"
}

variable "ubuntu-amis" {
  description = "Ubuntu Images avaiables."
  default = {
    us-east-1 = "ami-0261755bbcb8c4a84"
    us-east-2 = "ami-0430580de6244e02e"
    us-west-1 = "ami-04d1dcfb793f6fa37"
    us-west-2 = "ami-0c65adc9a5c1b5d7c"
  }
}

variable "region-keypair" {
  description = "Key Pairs"
  default = {
    us-east-1 = "kp_devops"
    us-east-2 = "kp_devops2"
    us-west-1 = ""
    us-west-2 = ""
  }
}
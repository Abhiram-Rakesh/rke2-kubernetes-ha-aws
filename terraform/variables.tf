
variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "project_name" {
  type    = string
  default = "rke2-ha-poc"
}

variable "rke2_version" {
  type    = string
  default = "v1.29.3+rke2r1"
}

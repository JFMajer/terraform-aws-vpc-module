
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "name_prefix" {
  type    = string
  default = "dev-"
}

variable "public_subnets_count" {
  type    = number
  default = 2
}

variable "private_subnets_count" {
  type    = number
  default = 2
}

variable "availability_zones" {
  type    = list(any)
  default = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
}
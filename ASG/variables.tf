variable "vpc_cidr_block" {
  default = "100.0.0.0/16"
}

variable "image_id" {
  default = "ami-0360c520857e3138f"
}

variable "instance_type" {
  default = "t2.micro"
}
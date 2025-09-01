variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string

}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.medium"

}

variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
}

variable "volume_size" {
  description = "The size of the root volume in GiB"
  type        = number
}

variable "server_name" {
  description = "The name of the server"
  type        = string
}

variable "region_name" {
  description = "The AWS region to deploy the instance in"
  type        = string
}

variable "vpc_cidr" {

}

variable "enable_dns_hostnames" {
  default = "true"
}

variable "public_subnet_cidr" {

}

variable "private_subnet_cidr" {

}

variable "database_subnet_cidr" {

}

variable "availability_zone" {

}






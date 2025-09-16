variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = map(string) # key = AZ name, value = subnet ID
}

variable "private_subnet_ids" {
  type = map(string) # key = AZ name, value = subnet ID
}

variable "nat_gateway_ids" {
  type = map(string) # key = AZ name, value = NAT GW ID
}

variable "igw_id" {
  type = string
}

variable "name" {
  type = string
}

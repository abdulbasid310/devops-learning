variable "vpc_cidr" {
    description = "CIDR block for the vpc"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "cidr block for the public subnet"
    type = string
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr_1" {
    description = "cidr block for the private subnet"
    type = string
    default = "10.0.1.0/24"
}

variable "private_subnet_cidr_2" {
    description = "cidr block for the private subnet"
    type = string
    default = "10.0.2.0/24"
}

variable "availability_zones" {
    description = "Availability zones for the subnets"
    type = list(string)
    default = ["eu-west-1a", "eu-west-1b"]
}

variable "db_name" {
    description = "Database name"
    type = string
}

variable "db_user" {
    description = "Database user"
    type = string
}

variable "db_password" {
    description = "Database password"
    type = string
    sensitive = true
}    
    
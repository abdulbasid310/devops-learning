resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr

}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.availability_zones[0]
    map_public_ip_on_launch = true

    tags = {
        Name = "public subnet"
    }
}

resource "aws_subnet" "private_subnet_1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_cidr_1
    availability_zone = var.availability_zones[0]
    map_public_ip_on_launch = false

    tags = {
        Name = "private subnet 1"
    }
}

resource "aws_subnet" "private_subnet_2" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_cidr_2
    availability_zone = var.availability_zones[1]
    map_public_ip_on_launch = false

    tags = {
        Name = "private subnet 2"
    }
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }
}

resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway.id
    }
}

resource "aws_route_table_association" "private_subnet_association_1" {
    subnet_id = aws_subnet.private_subnet_1.id
    route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_association_2" {
    subnet_id = aws_subnet.private_subnet_2.id
    route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "public_subnet_association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_eip" "eip" {
    domain = "vpc"
    depends_on = [ aws_internet_gateway.my_igw ]
}

resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = aws_eip.eip.id
    subnet_id = aws_subnet.public_subnet.id
    depends_on = [ aws_internet_gateway.my_igw ]
}   
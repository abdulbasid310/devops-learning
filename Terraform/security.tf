resource "aws_security_group" "wordpress_sg" {
    vpc_id = aws_vpc.my_vpc.id
    ingress {
        description = "Allow HTTP access from anywhere"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "Allow access to the internet"
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "rds_sg" {
    vpc_id = aws_vpc.my_vpc.id
    ingress {
        description = "Allows database access from EC2 instances"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.wordpress_sg.id]
    }
    egress {
        description = "Allow access to the internet"
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}
    


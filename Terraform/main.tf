resource "aws_instance" "wordpress_instance" {
    ami = "ami-0c13c2049f369d641"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.wordpress_sg.id]

    user_data = <<-EOT
    #!/bin/bash

    # Update system
    dnf update -y

    # Install Apache, PHP, MariaDB and tools
    dnf install -y \
        httpd \
        php \
        php-mysqlnd \
        wget \
        unzip

    # Start and enable Apache
    systemctl enable httpd
    systemctl start httpd


    # Download WordPress
    cd /tmp
    wget https://wordpress.org/latest.zip

    # Extract WordPress
    unzip latest.zip

    # Copy files
    cp -r wordpress/* /var/www/html/

    # Set permissions
    chown -R apache:apache /var/www/html


    # Configure WordPress
    cd /var/www/html

    cp wp-config-sample.php wp-config.php

    sed -i "s/database_name_here/${var.db_name}/" wp-config.php
    sed -i "s/username_here/${var.db_user}/" wp-config.php
    sed -i "s/password_here/${var.db_password}/" wp-config.php
    sed -i "s/localhost/${aws_db_instance.rdsinstance.address}/" wp-config.php

    # Restart Apache
    systemctl restart httpd

    echo "WordPress installation complete"
    EOT
}      


resource "aws_db_instance" "rdsinstance" {
    allocated_storage = 10
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t3.micro"
    identifier = var.db_name
    db_name = var.db_name
    username = var.db_user
    password = var.db_password
    parameter_group_name = "default.mysql8.0"
    db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
    skip_final_snapshot = true
    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    tags = {
        Name = "Mydb"
    }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
    name = "rds_subnet_group"

    subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}    
    

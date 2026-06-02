In this assignment I  deployed two EC2 instances behind an ALB that handled all incoming traffic 
and did not allow the EC2 instances to be accessible directly from the internet. The ALB switches 
traffic between the two EC2 instances and has a health check configured.

Security:
ALB security group allows HTTP from anywhere
EC2 security group allows HTTP only from the ALB security group

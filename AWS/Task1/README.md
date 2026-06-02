This project demonstrates how to create a custom network on AWS from scratch

Architecture:
1 VPC
1 public subnet 1 private subnet
Internet gateway for public access
NAT gateway for private outbound access
1 EC2 instance in each subnet

Public EC2 instance:
Deployed in public subnet
Has a public IP address
Accessible by SSH from my address

Private EC2 instance:
Deployed in private subnet
No public IP
Only accessible from public EC2


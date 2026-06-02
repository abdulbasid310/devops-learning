resource "aws_instance" "this" {
    ami = "ami-03cc8375791cb8bcf"
    instance_type = "t3.micro"

}
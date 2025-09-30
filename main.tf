resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id = aws_vpc.main.id
  # cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, 1)
  tags = {
    subnet-type = "public"
  }
}
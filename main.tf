resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
  }
}

resource "aws_subnet" "public_subnets" {
  count = var.subnets_count
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 1)

  tags = {
    subnet-type = "public"
  }
}

resource "aws_subnet" "private_subnets" {
  count = var.subnets_count
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, var.subnets_count + count.index + 1)

  tags = {
    subnet-type = "private"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
  }
}

resource "aws_route_table" "app_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
  }
}

resource "aws_route" "ig_route" {
  route_table_id = aws_route_table.app_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_subnet_association" {
  count = var.subnets_count
  subnet_id = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.app_route_table.id
}
locals {
  vpc_name = "${var.name_prefix}-vpc"
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = local.vpc_name
  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.${count.index * 2 + 1}.0/24"
  availability_zone = element(var.availability_zones, count.index)

  count = var.public_subnets_count

  tags = {
    Name = "public_10.0.${count.index * 2 + 1}.0_${element(var.availability_zones, count.index)}"
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.${count.index * 2}.0/24"
  availability_zone = element(var.availability_zones, count.index)

  count = var.private_subnets_count

  tags = {
    Name = "private_10.0.${count.index * 2}.0_${element(var.availability_zones, count.index)}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw-${local.vpc_name}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt-${local.vpc_name}"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  count          = var.public_subnets_count
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "eip-nat-${local.vpc_name}"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = element(aws_subnet.public_subnets.*.id, 0)

  tags = {
    Name = "nat-${local.vpc_name}"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private_rt_${local.vpc_name}"
  }
}

resource "aws_route_table_association" "private_rt_association" {
  count          = var.private_subnets_count
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

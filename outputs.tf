output "vpc_id" {
  value = aws_vpc.vpc.id
  description = "value of the vpc id"
}

# public subnets ids
output "public_subnets_ids" {
  value = aws_subnet.public_subnets.*.id
  description = "value of the public subnets ids"
}

# private subnets ids
output "private_subnets_ids" {
  value = aws_subnet.private_subnets.*.id
  description = "value of the private subnets ids"
}

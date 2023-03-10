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

output "private_rds_subnets_ids" {
  value = aws_subnet.private_rds_subnets.*.id
  description = "value of the private rds subnets ids"
}

output "rds_subnet_group_id" {
  value = aws_db_subnet_group.rds_mysql.id
  description = "value of the rds subnet group id"
}

output "rds_subnet_group_name" {
  value = aws_db_subnet_group.rds_mysql.name
  description = "value of the rds subnet group name"
}
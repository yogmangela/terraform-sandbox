output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "web_elb_dns" {
  value = module.ec2.elb_name
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

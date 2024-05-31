output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_instance_id" {
  value = module.instances.public_instance_id
}

output "private_instance_id" {
  value = module.instances.private_instance_id
}

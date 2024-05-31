output "public_instance_id" {
  value = aws_instance.success.id
}

output "private_instance_id" {
  value = aws_instance.happy.id
}

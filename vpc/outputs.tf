output "vpc_id" {
  value = aws_vpc.test_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.test_pubsub.id
}

output "private_subnet_id" {
  value = aws_subnet.test_pvtsub.id
}

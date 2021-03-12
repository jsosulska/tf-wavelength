output "vpc_id" {
  description = "The id of the created VPC"
  value       = aws_vpc.managed[0].id
}

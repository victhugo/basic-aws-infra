output "vpc_subnet" {
  value = aws_subnet.subnet-1-public.id
}

output "vpc_id" {
  value = aws_vpc.vhugo_vpc.id
}

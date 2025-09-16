output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_ids" {
  value = { for k, v in aws_route_table.private : k => v.id }
}

output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}


output "web_security_group_id" {
  value = aws_security_group.web_sg.id
}
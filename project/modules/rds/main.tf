resource "aws_db_subnet_group" "main" {
  name       = "main-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "main" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name                 = "mydb"
  username             = "foo"
  password             = "bar"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  publicly_accessible  = false

  vpc_security_group_ids = [
    var.security_group,
  ]

  db_subnet_group_name = aws_db_subnet_group.main.name

  multi_az = true

  performance_insights_enabled = true

  monitoring_interval = 60
}

output "rds_endpoint" {
  value = aws_db_instance.main.endpoint
}

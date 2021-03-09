resource "aws_db_instance" "example" {
  allocated_storage   = 20
  storage_type        = "gp2"
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t2.micro"
  username            = var.DATABASE_USER
  password            = var.DATABASE_PASSWORD
  publicly_accessible = true
  tags = {
    "identifier" = "example"
  }
}

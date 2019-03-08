output "postgres_password" {
  value = "${random_string.password.result}"
}

output "postgres_endpoint" {
  value = "${aws_db_instance.this.endpoint}"
} 

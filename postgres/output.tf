output "postgres_password" {
  value = "${random_string.password.result}"
}

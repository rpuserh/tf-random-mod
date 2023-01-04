variable "random_count" {
  type = number
}

resource "random_password" "password" {
  count = var.random_count

  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

output "pass" {
  value = random_password.password.*.result
  sensitive = true
}

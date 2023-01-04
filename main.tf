variable "count" {
  type = number
}

resource "random_password" "password" {
  count = var.count

  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

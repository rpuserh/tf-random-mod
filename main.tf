variable "random_count" {
  type = number
}

resource "random_id" "this" {
  count = var.random_count

  byte_length = 8
}

output "pass" {
  value = random_id.this.*.id
}

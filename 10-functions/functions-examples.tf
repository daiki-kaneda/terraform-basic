locals {
  name = "John Smith"
  age = 20
}

output "example1" {
  value = startswith(lower(local.name),"john")
}

output "example2" {
  value = pow(abs(local.age),2)
}

output "example3" {
  value = yamldecode(file("${path.module}/users.yaml")).users[*].name
}
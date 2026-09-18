locals {
  double_numbers = [for num in var.numbers_list : num * 2]
  even_numbers   = [for num in var.numbers_list : num if num % 2 == 0]
  first_names    = [for person in var.objects_list : person.firstname]
  full_names     = [for person in var.objects_list : "${person.firstname} ${person.lastname}"]
}

output "even_numbers" {
  value = local.even_numbers
}
output "first_names" {
  value = local.first_names
}
output "full_names" {
  value = local.full_names
}
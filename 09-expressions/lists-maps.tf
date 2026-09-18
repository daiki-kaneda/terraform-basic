locals {
  user_map = {
    for user_info in var.users : user_info.username => user_info.role...
  }
  user_map2 = {
    for username, roles in local.user_map : username => { roles = roles }
  }

  user_names_from_map = [for username, roles in local.user_map : username]
}

output "user_map" {
  value = local.user_map
}

output "user_names_from_map" {
  value = local.user_names_from_map
}

output "user_map2" {
  value = local.user_map2
}

output "user_to_output_roles" {
  value = local.user_map2[var.user_to_output]
}
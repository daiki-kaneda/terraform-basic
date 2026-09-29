variable "hcp_terraform_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "HCP Terraform hostname without https://"
}
variable "hcp_terraform_audience" {
  type        = string
  default     = "aws.workload.identity"
  description = "HCP Terraform audience"
}
variable "admin_role_workspaces" {
  type        = list(string)
  description = "All workspaces that can asssume admin role"
  default     = ["terraform-oidc"]
}
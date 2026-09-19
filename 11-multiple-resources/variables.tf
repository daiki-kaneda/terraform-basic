variable "subnet_config" {
  type = map(object({
    cidr_block = string
  }))

  validation {
    condition = alltrue([
      # canは与えられた式がエラーなく評価されるかをチェックする述語
      for key, config in var.subnet_config : can(cidrnetmask(config.cidr_block))
    ])
    error_message = "少なくとも一つのCIDRブロックが無効です。"
  }
}

variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami           = string
    subnet_name   = optional(string, "default")
  }))

  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : config.instance_type == "t2.micro"
    ])
    error_message = "少なくとも一つのインスタンスタイプが無効な値です。instance_typeは\"t2.micro\"のみがサポートされています。"
  }
  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["ubuntu", "amazon_linux"], config.ami)
    ])
    error_message = "少なくとも一つのAMIが無効です。amiは\"ubuntu\"と\"amazon_linux\"のみサポートされています。"
  }
}

variable "ec2_instance_config_map" {
  type = map(object({
    instance_type = string
    ami           = string
    subnet_name   = optional(string, "default")
  }))

  validation {
    condition = alltrue([
      for key, config in var.ec2_instance_config_map : config.instance_type == "t2.micro"
    ])
    error_message = "少なくとも一つのインスタンスタイプが無効な値です。instance_typeは\"t2.micro\"のみがサポートされています。"
  }
  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["ubuntu", "amazon_linux"], config.ami)
    ])
    error_message = "少なくとも一つのAMIが無効です。amiは\"ubuntu\"と\"amazon_linux\"のみサポートされています。"
  }
}

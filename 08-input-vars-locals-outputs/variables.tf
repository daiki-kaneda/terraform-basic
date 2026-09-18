variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "管理しているEC2インスタンスのタイプ"
  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    error_message = "t2.microまたはt3.microのみをサポートしています"
  }
}

variable "ec2_volume_config" {
  type = object({
    size = number
    type = string
  })
  description = "EC2インスタンスのルートボリュームのサイズとタイプ"
  default = {
    size = 10
    type = "gp3"
  }
}

variable "additional_tags" {
  # キーの値など事前にわからない場合にmap,明確な場合にobjectを使う
  type    = map(string)
  default = {}
}

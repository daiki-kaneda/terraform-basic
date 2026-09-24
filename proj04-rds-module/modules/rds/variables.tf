####################
# 一般設定
####################

variable "project_name" {
  type        = string
  description = "プロジェクト名.RDSインスタンスの名前や関連するタグなどに使われます."
}

####################
# データベース設定
####################

variable "instance_class" {
  type        = string
  description = "RDSインスタンスを作成するのに使われるインスタンスクラス."
  default     = "db.t3.micro"
  validation {
    condition     = contains(["db.t3.micro"], var.instance_class)
    error_message = "db.t3.microのみを使用可能です。"
  }
}

variable "storage_size" {
  type        = number
  description = "RDSインスタンスに割り当てられるストレージのサイズ."
  default     = 10
  validation {
    condition     = var.storage_size >= 5 && var.storage_size <= 10
    error_message = "RDSインスタンスのストレージは5GB以上10GB以下にしてください。"
  }
}

variable "engine" {
  type        = string
  description = "データベースに使用されるエンジン.現在はPostgresのみがサポートされます。"
  default     = "postgres-latest"
  validation {
    condition     = contains(["postgres-latest", "postgres-14"], var.engine)
    error_message = "データベースエンジンは\"postgres-latest\"または\"postgres-14\"にしてください。"
  }
}

variable "credentials" {
  type = object({
    username = string
    password = string
  })
  description = "データベース作成時に使用されるルートユーザ名とパスワード."
  sensitive   = true

  validation {
    condition = (
      length(regexall("[a-zA-Z]+", var.credentials.password)) > 0 &&
      length(regexall("[0-9]+", var.credentials.password)) > 0 &&
      length(regexall("^[a-zA-Z0-9+_?-]{8,}$", var.credentials.password)) > 0
    )
    error_message = <<-EOT
    パスワードは以下の条件を満たす必要があります。
    1. 少なくとも1文字のキャラクターを含む
    2. 少なくとも1文字の数字を含む
    3. 全体で8文字以上にする
    パスワードは英数字、+,_,?,-が使えます。また、全体で六文字以上である必要があります。
    EOT
  }
}

####################
# ネットワーク
####################

variable "subnet_ids" {
  type        = list(string)
  description = "RDSインスタンスをデプロイするのに使用されるサブネットIDのリスト"
}

variable "security_group_ids" {
  type        = list(string)
  description = "RDSインスタンスにアタッチされるセキュリティグループのIDのリスト"
}
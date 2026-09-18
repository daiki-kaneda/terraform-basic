locals {
  math       = 2 * 2         # 算術演算子: *, /, +, -, -<number>, %
  equality   = 2 == 2        # 等価演算子: ==, !=
  comparison = 2 >= 1        # 比較演算子: <, <=, >, >=
  logical    = true && false # 論理演算子: && || 
}

output "operators" {
  value = {
    math       = local.math
    equality   = local.equality
    comparison = local.comparison
    logical    = local.logical
  }
}
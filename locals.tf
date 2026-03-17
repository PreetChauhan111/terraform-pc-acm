locals {
  common_tags = {
    Environment = var.environment
    Owner       = "pc"
    GitHubRepo  = "terraform-pc-acm"
  }
  common_name = "${local.common_tags["Owner"]}-${var.environment}-${var.region}-acm"
  tags        = merge(local.common_tags, var.tags, { Name = local.common_name })

}
locals {
  merged_tags = merge(
    var.tags_map,
    {
      Environment = "${var.environment}"
    }
  )
}

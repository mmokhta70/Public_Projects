output "common_tags" {
  description = "Merged map of all common tags to apply to every resource"
  value       = local.global_tags
}
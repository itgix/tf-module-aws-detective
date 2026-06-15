output "detective_graph_arn" {
  description = "ARN of the Amazon Detective behavior graph."
  value       = try(aws_detective_graph.itgix_primary[0].graph_arn, null)
}

output "detective_graph_id" {
  description = "ID of the Amazon Detective behavior graph."
  value       = try(aws_detective_graph.itgix_primary[0].id, null)
}

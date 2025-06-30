# Global Cluster Outputs
output "global_cluster_arn" {
  description = "Global cluster ARN"
  value       = try(aws_docdb_global_cluster.this[0].arn, null)
}

output "global_cluster_id" {
  description = "Global cluster ID"
  value       = try(aws_docdb_global_cluster.this[0].id, null)
}

output "global_cluster_resource_id" {
  description = "Global cluster resource ID"
  value       = try(aws_docdb_global_cluster.this[0].global_cluster_resource_id, null)
}

# Subnet Group Outputs
output "subnet_group_arn" {
  description = "Subnet group ARN"
  value       = try(aws_docdb_subnet_group.this[0].arn, null)
}

output "subnet_group_name" {
  description = "Subnet group name"
  value       = try(aws_docdb_subnet_group.this[0].name, null)
}

# Parameter Group Outputs
output "parameter_group_arn" {
  description = "Parameter group ARN"
  value       = try(aws_docdb_cluster_parameter_group.this[0].arn, null)
}

output "parameter_group_name" {
  description = "Parameter group name"
  value       = try(aws_docdb_cluster_parameter_group.this[0].name, null)
}

# Cluster Outputs
output "cluster_arn" {
  description = "DocumentDB cluster ARN"
  value       = aws_docdb_cluster.this.arn
}

output "cluster_id" {
  description = "DocumentDB cluster ID"
  value       = aws_docdb_cluster.this.id
}

output "cluster_identifier" {
  description = "DocumentDB cluster identifier"
  value       = aws_docdb_cluster.this.cluster_identifier
}

output "cluster_endpoint" {
  description = "DocumentDB cluster endpoint"
  value       = aws_docdb_cluster.this.endpoint
}

output "cluster_reader_endpoint" {
  description = "DocumentDB cluster reader endpoint"
  value       = aws_docdb_cluster.this.reader_endpoint
}

output "cluster_port" {
  description = "DocumentDB cluster port"
  value       = aws_docdb_cluster.this.port
}

output "cluster_hosted_zone_id" {
  description = "DocumentDB cluster hosted zone ID"
  value       = aws_docdb_cluster.this.hosted_zone_id
}

output "cluster_resource_id" {
  description = "DocumentDB cluster resource ID"
  value       = aws_docdb_cluster.this.cluster_resource_id
}

output "cluster_master_username" {
  description = "DocumentDB cluster master username"
  value       = aws_docdb_cluster.this.master_username
}

output "cluster_master_user_secret" {
  description = "DocumentDB cluster master user secret"
  value       = aws_docdb_cluster.this.master_user_secret
  sensitive   = true
}

# Instance Outputs
output "cluster_instances" {
  description = "DocumentDB cluster instances"
  value = {
    for k, v in aws_docdb_cluster_instance.this : k => {
      arn                          = v.arn
      identifier                   = v.identifier
      endpoint                     = v.endpoint
      port                         = v.port
      instance_class               = v.instance_class
      availability_zone            = v.availability_zone
      ca_cert_identifier           = v.ca_cert_identifier
      dbi_resource_id              = v.dbi_resource_id
      kms_key_id                   = v.kms_key_id
      preferred_backup_window      = v.preferred_backup_window
      preferred_maintenance_window = v.preferred_maintenance_window
      promotion_tier               = v.promotion_tier
      storage_encrypted            = v.storage_encrypted
      writer                       = v.writer
    }
  }
}

# Snapshot Outputs
output "cluster_snapshot_arn" {
  description = "DocumentDB cluster snapshot ARN"
  value       = try(aws_docdb_cluster_snapshot.this[0].db_cluster_snapshot_arn, null)
}

output "cluster_snapshot_identifier" {
  description = "DocumentDB cluster snapshot identifier"
  value       = try(aws_docdb_cluster_snapshot.this[0].db_cluster_snapshot_identifier, null)
}

# Event Subscription Outputs
output "event_subscription_arn" {
  description = "DocumentDB event subscription ARN"
  value       = try(aws_docdb_event_subscription.this[0].arn, null)
}

output "event_subscription_name" {
  description = "DocumentDB event subscription name"
  value       = try(aws_docdb_event_subscription.this[0].name, null)
}

output "event_subscription_customer_aws_id" {
  description = "DocumentDB event subscription customer AWS ID"
  value       = try(aws_docdb_event_subscription.this[0].customer_aws_id, null)
}
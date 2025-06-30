variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "customer_name" {
  description = "Customer name for tagging resources"
  type        = string
}

variable "environment" {
  description = "Environment for tagging resources (e.g., dev, staging, prod)"
  type        = string
}

# Global Cluster
variable "create_global_cluster" {
  description = "Whether to create a global cluster"
  type        = bool
  default     = false
}

variable "global_cluster_identifier" {
  description = "Global cluster identifier"
  type        = string
  default     = null
}

variable "global_cluster_engine" {
  description = "Engine for global cluster"
  type        = string
  default     = "docdb"
}

variable "global_cluster_engine_version" {
  description = "Engine version for global cluster"
  type        = string
  default     = null
}

variable "global_cluster_database_name" {
  description = "Database name for global cluster"
  type        = string
  default     = null
}

variable "global_cluster_deletion_protection" {
  description = "Deletion protection for global cluster"
  type        = bool
  default     = false
}

variable "global_cluster_storage_encrypted" {
  description = "Storage encryption for global cluster"
  type        = bool
  default     = true
}

variable "global_cluster_source_db_cluster_identifier" {
  description = "Source DB cluster identifier for global cluster"
  type        = string
  default     = null
}

# Subnet Group
variable "create_subnet_group" {
  description = "Whether to create subnet group"
  type        = bool
  default     = true
}

variable "subnet_group_name" {
  description = "Name of the subnet group"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
  default     = []
}

variable "subnet_group_tags" {
  description = "Tags for subnet group"
  type        = map(string)
  default     = {}
}

# Parameter Group
variable "create_parameter_group" {
  description = "Whether to create parameter group"
  type        = bool
  default     = true
}

variable "parameter_group_name" {
  description = "Name of the parameter group"
  type        = string
  default     = null
}

variable "parameter_group_family" {
  description = "Parameter group family"
  type        = string
  default     = "docdb5.0"
}

variable "parameter_group_description" {
  description = "Description of parameter group"
  type        = string
  default     = "DocumentDB cluster parameter group"
}

variable "parameters" {
  description = "List of parameters to apply"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "parameter_group_tags" {
  description = "Tags for parameter group"
  type        = map(string)
  default     = {}
}

# Cluster
variable "cluster_identifier" {
  description = "Cluster identifier"
  type        = string
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "docdb"
}

variable "engine_version" {
  description = "Engine version"
  type        = string
  default     = "5.0.0"
}

variable "master_username" {
  description = "Master username"
  type        = string
  default     = "docdbadmin"
}

variable "master_password" {
  description = "Master password"
  type        = string
  sensitive   = true
  default     = null
}

variable "manage_master_user_password" {
  description = "Whether to manage master user password with AWS Secrets Manager"
  type        = bool
  default     = false
}

variable "master_user_secret_kms_key_id" {
  description = "KMS key ID for master user secret"
  type        = string
  default     = null
}

variable "backup_retention_period" {
  description = "Backup retention period"
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "Preferred backup window"
  type        = string
  default     = "07:00-09:00"
}

variable "preferred_maintenance_window" {
  description = "Preferred maintenance window"
  type        = string
  default     = "sun:05:00-sun:06:00"
}

variable "port" {
  description = "Database port"
  type        = number
  default     = 27017
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs"
  type        = list(string)
  default     = []
}

variable "storage_encrypted" {
  description = "Whether storage is encrypted"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key ID for encryption"
  type        = string
  default     = null
}

variable "storage_type" {
  description = "Storage type"
  type        = string
  default     = null
}

variable "apply_immediately" {
  description = "Whether to apply changes immediately"
  type        = bool
  default     = false
}

variable "db_cluster_parameter_group_name" {
  description = "DB cluster parameter group name"
  type        = string
  default     = null
}

variable "db_subnet_group_name" {
  description = "DB subnet group name"
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "Whether deletion protection is enabled"
  type        = bool
  default     = false
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to CloudWatch"
  type        = list(string)
  default     = ["audit", "profiler"]
}

variable "final_snapshot_identifier" {
  description = "Final snapshot identifier"
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Whether to skip final snapshot"
  type        = bool
  default     = false
}

variable "snapshot_identifier" {
  description = "Snapshot identifier to restore from"
  type        = string
  default     = null
}

variable "global_cluster_identifier_ref" {
  description = "Global cluster identifier reference"
  type        = string
  default     = null
}

variable "restore_to_point_in_time" {
  description = "Point in time restore configuration"
  type = object({
    source_cluster_identifier  = string
    restore_to_time            = optional(string)
    use_latest_restorable_time = optional(bool)
    restore_type               = optional(string)
  })
  default = null
}

variable "cluster_tags" {
  description = "Tags for cluster"
  type        = map(string)
  default     = {}
}

# Cluster Instances
variable "instances" {
  description = "Map of cluster instances"
  type = map(object({
    identifier                      = optional(string)
    instance_class                  = string
    apply_immediately               = optional(bool)
    auto_minor_version_upgrade      = optional(bool)
    availability_zone               = optional(string)
    ca_cert_identifier              = optional(string)
    copy_tags_to_snapshot           = optional(bool)
    enable_performance_insights     = optional(bool)
    performance_insights_kms_key_id = optional(string)
    preferred_maintenance_window    = optional(string)
    promotion_tier                  = optional(number)
    tags                            = optional(map(string))
  }))
  default = {}
}

# Cluster Snapshot
variable "create_cluster_snapshot" {
  description = "Whether to create cluster snapshot"
  type        = bool
  default     = false
}

variable "cluster_snapshot_identifier" {
  description = "Cluster snapshot identifier"
  type        = string
  default     = null
}

variable "cluster_snapshot_tags" {
  description = "Tags for cluster snapshot"
  type        = map(string)
  default     = {}
}

# Event Subscription
variable "create_event_subscription" {
  description = "Whether to create event subscription"
  type        = bool
  default     = false
}

variable "event_subscription_name" {
  description = "Event subscription name"
  type        = string
  default     = null
}

variable "event_subscription_sns_topic_arn" {
  description = "SNS topic ARN for event subscription"
  type        = string
  default     = null
}

variable "event_categories" {
  description = "List of event categories"
  type        = list(string)
  default     = []
}

variable "source_type" {
  description = "Source type for event subscription"
  type        = string
  default     = "db-cluster"
}

variable "source_ids" {
  description = "List of source IDs"
  type        = list(string)
  default     = []
}

variable "event_subscription_enabled" {
  description = "Whether event subscription is enabled"
  type        = bool
  default     = true
}

variable "event_subscription_tags" {
  description = "Tags for event subscription"
  type        = map(string)
  default     = {}
}

# Common Tags
variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
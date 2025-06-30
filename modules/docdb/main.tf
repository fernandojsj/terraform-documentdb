# Global Cluster
resource "aws_docdb_global_cluster" "this" {
  count = var.create_global_cluster ? 1 : 0

  global_cluster_identifier    = var.global_cluster_identifier
  engine                       = var.global_cluster_engine
  engine_version               = var.global_cluster_engine_version
  database_name                = var.global_cluster_database_name
  deletion_protection          = var.global_cluster_deletion_protection
  storage_encrypted            = var.global_cluster_storage_encrypted
  source_db_cluster_identifier = var.global_cluster_source_db_cluster_identifier
}

# Subnet Group
resource "aws_docdb_subnet_group" "this" {
  count = var.create_subnet_group ? 1 : 0

  name       = var.subnet_group_name != null ? var.subnet_group_name : "${var.cluster_identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, var.subnet_group_tags)
}

# Parameter Group
resource "aws_docdb_cluster_parameter_group" "this" {
  count = var.create_parameter_group ? 1 : 0

  name        = var.parameter_group_name != null ? var.parameter_group_name : "${var.cluster_identifier}-parameter-group"
  family      = var.parameter_group_family
  description = var.parameter_group_description

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = merge(var.tags, var.parameter_group_tags)
}

# DocumentDB Cluster
resource "aws_docdb_cluster" "this" {
  cluster_identifier              = var.cluster_identifier
  engine                          = var.engine
  engine_version                  = var.engine_version
  master_username                 = var.master_username
  master_password                 = var.manage_master_user_password ? null : var.master_password
  manage_master_user_password     = var.manage_master_user_password ? true : null
  # master_user_secret_kms_key_id   = var.manage_master_user_password ? var.master_user_secret_kms_key_id : null
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window
  port                            = var.port
  vpc_security_group_ids          = var.vpc_security_group_ids
  storage_encrypted               = var.storage_encrypted
  kms_key_id                      = var.kms_key_id
  storage_type                    = var.storage_type
  apply_immediately               = var.apply_immediately
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name != null ? var.db_cluster_parameter_group_name : try(aws_docdb_cluster_parameter_group.this[0].name, null)
  db_subnet_group_name            = var.db_subnet_group_name != null ? var.db_subnet_group_name : try(aws_docdb_subnet_group.this[0].name, null)
  deletion_protection             = var.deletion_protection
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  final_snapshot_identifier       = var.final_snapshot_identifier
  skip_final_snapshot             = var.skip_final_snapshot
  snapshot_identifier             = var.snapshot_identifier
  global_cluster_identifier       = var.global_cluster_identifier_ref != null ? var.global_cluster_identifier_ref : try(aws_docdb_global_cluster.this[0].id, null)

  tags = merge(var.tags, var.cluster_tags)

  depends_on = [
    aws_docdb_subnet_group.this,
    aws_docdb_cluster_parameter_group.this,
    aws_docdb_global_cluster.this
  ]
}

# Cluster Instances
resource "aws_docdb_cluster_instance" "this" {
  for_each = var.instances

  identifier                      = each.value.identifier != null ? each.value.identifier : "${var.cluster_identifier}-${each.key}"
  cluster_identifier              = aws_docdb_cluster.this.id
  instance_class                  = each.value.instance_class
  apply_immediately               = each.value.apply_immediately
  auto_minor_version_upgrade      = each.value.auto_minor_version_upgrade
  availability_zone               = each.value.availability_zone
  ca_cert_identifier              = each.value.ca_cert_identifier
  copy_tags_to_snapshot           = each.value.copy_tags_to_snapshot
  enable_performance_insights     = each.value.enable_performance_insights
  performance_insights_kms_key_id = each.value.performance_insights_kms_key_id
  preferred_maintenance_window    = each.value.preferred_maintenance_window
  promotion_tier                  = each.value.promotion_tier

  tags = merge(var.tags, each.value.tags)
}

# Cluster Snapshot
resource "aws_docdb_cluster_snapshot" "this" {
  count = var.create_cluster_snapshot ? 1 : 0

  db_cluster_identifier          = aws_docdb_cluster.this.id
  db_cluster_snapshot_identifier = var.cluster_snapshot_identifier != null ? var.cluster_snapshot_identifier : "${var.cluster_identifier}-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
}

# Event Subscription
resource "aws_docdb_event_subscription" "this" {
  count = var.create_event_subscription ? 1 : 0

  name             = var.event_subscription_name != null ? var.event_subscription_name : "${var.cluster_identifier}-events"
  sns_topic_arn    = var.event_subscription_sns_topic_arn
  event_categories = var.event_categories
  source_type      = var.source_type
  source_ids       = length(var.source_ids) > 0 ? var.source_ids : [aws_docdb_cluster.this.id]
  enabled          = var.event_subscription_enabled

  tags = merge(var.tags, var.event_subscription_tags)
}
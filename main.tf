module "documentdb" {
  source = "./modules/docdb"

  # Configuração básica
  cluster_identifier = var.cluster_identifier
  master_username    = var.master_username
  master_password    = var.master_password

  # Rede e segurança
  subnet_ids             = var.subnet_ids
  vpc_security_group_ids = var.vpc_security_group_ids

  # Instâncias do cluster
  instances = var.instances

  # Backup e manutenção
  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window

  # Segurança
  storage_encrypted   = var.storage_encrypted
  deletion_protection = var.deletion_protection

  # Parâmetros customizados
  parameters = var.parameters

  # Recursos opcionais
  create_global_cluster                = var.create_global_cluster
  global_cluster_identifier            = var.global_cluster_identifier
  create_cluster_snapshot              = var.create_cluster_snapshot
  cluster_snapshot_identifier          = var.cluster_snapshot_identifier
  create_event_subscription            = var.create_event_subscription
  event_subscription_sns_topic_arn     = var.event_subscription_sns_topic_arn
  event_categories                     = var.event_categories

  # Tags
  tags = merge(var.tags, {
    Customer    = var.customer_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "terraform-aws-docdb"
  })
}
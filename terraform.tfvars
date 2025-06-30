# Configurações básicas
aws_region = "us-east-1"
customer_name = "minha-empresa"
environment = "dev"

# Cluster DocumentDB
cluster_identifier = "meu-cluster-docdb"
master_username = "docdbadmin"
master_password = "SuaSenhaSegura123!"

# Rede
subnet_ids = ["subnet-xxxxxxxxx", "subnet-yyyyyyyyy"]
vpc_security_group_ids = ["sg-xxxxxxxxx"]

# Instâncias
instances = {
  primary = {
    instance_class = "db.t3.medium"
    promotion_tier = 0
  }
  replica1 = {
    instance_class = "db.t3.medium"
    promotion_tier = 1
  }
}

# Backup e manutenção
backup_retention_period = 7
preferred_backup_window = "07:00-09:00"
preferred_maintenance_window = "sun:05:00-sun:06:00"

# Segurança
storage_encrypted = true
deletion_protection = false

# Tags
tags = {
  Environment = "development"
  Project     = "meu-projeto"
  Owner       = "minha-equipe"
}

# Parâmetros customizados (opcional)
# parameters = [
#   {
#     name  = "audit_logs"
#     value = "enabled"
#   }
# ]

# Recursos opcionais
# create_event_subscription = true
# event_subscription_sns_topic_arn = "arn:aws:sns:us-east-1:123456789012:docdb-events"
# event_categories = ["backup", "failure", "maintenance"]
# create_global_cluster = true
# global_cluster_identifier = "meu-cluster-global"
# create_cluster_snapshot = true
# cluster_snapshot_identifier = "meu-snapshot-manual"
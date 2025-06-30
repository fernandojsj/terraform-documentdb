# Terraform AWS DocumentDB Module

Este módulo Terraform cria recursos completos do Amazon DocumentDB (MongoDB compatível) na AWS.

## Recursos Criados

- `aws_docdb_global_cluster` - Cluster global do DocumentDB
- `aws_docdb_cluster` - Cluster principal do DocumentDB
- `aws_docdb_cluster_instance` - Instâncias do cluster
- `aws_docdb_cluster_parameter_group` - Grupo de parâmetros do cluster
- `aws_docdb_cluster_snapshot` - Snapshot do cluster
- `aws_docdb_event_subscription` - Assinatura de eventos
- `aws_docdb_subnet_group` - Grupo de subnets

## Uso Básico

```hcl
module "documentdb" {
  source = "./terraform-aws-clouddog-docdb"

  cluster_identifier = "my-docdb-cluster"
  master_username    = "admin"
  master_password    = "mypassword123"
  
  subnet_ids = ["subnet-12345", "subnet-67890"]
  vpc_security_group_ids = ["sg-12345"]

  instances = {
    primary = {
      instance_class = "db.t3.medium"
    }
    replica = {
      instance_class = "db.t3.medium"
    }
  }

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

## Uso Avançado com Todos os Recursos

```hcl
module "documentdb" {
  source = "./terraform-aws-clouddog-docdb"

  # Global Cluster
  create_global_cluster = true
  global_cluster_identifier = "my-global-cluster"

  # Cluster Principal
  cluster_identifier = "my-docdb-cluster"
  engine_version     = "5.0.0"
  master_username    = "admin"
  manage_master_user_password = true
  
  # Networking
  subnet_ids = ["subnet-12345", "subnet-67890"]
  vpc_security_group_ids = ["sg-12345"]
  
  # Backup e Manutenção
  backup_retention_period = 14
  preferred_backup_window = "03:00-05:00"
  preferred_maintenance_window = "sun:05:00-sun:06:00"
  
  # Segurança
  storage_encrypted = true
  deletion_protection = true
  
  # Parâmetros Customizados
  parameters = [
    {
      name  = "audit_logs"
      value = "enabled"
    }
  ]
  
  # Instâncias
  instances = {
    primary = {
      instance_class = "db.r5.large"
      promotion_tier = 0
    }
    replica1 = {
      instance_class = "db.r5.large"
      promotion_tier = 1
      availability_zone = "us-west-2a"
    }
    replica2 = {
      instance_class = "db.r5.large"
      promotion_tier = 2
      availability_zone = "us-west-2b"
    }
  }
  
  # Snapshot
  create_cluster_snapshot = true
  cluster_snapshot_identifier = "my-cluster-snapshot"
  
  # Event Subscription
  create_event_subscription = true
  event_subscription_sns_topic_arn = "arn:aws:sns:us-west-2:123456789012:docdb-events"
  event_categories = ["backup", "failure", "maintenance"]

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

## Variáveis Principais

| Nome | Descrição | Tipo | Padrão | Obrigatório |
|------|-----------|------|---------|-------------|
| cluster_identifier | Identificador do cluster | string | - | sim |
| master_username | Nome de usuário master | string | "docdbadmin" | não |
| master_password | Senha master | string | null | não |
| subnet_ids | Lista de IDs das subnets | list(string) | [] | não |
| instances | Mapa das instâncias do cluster | map(object) | {} | não |

## Outputs Principais

| Nome | Descrição |
|------|-----------|
| cluster_endpoint | Endpoint do cluster |
| cluster_reader_endpoint | Endpoint de leitura do cluster |
| cluster_arn | ARN do cluster |
| cluster_instances | Informações das instâncias |

## Exemplos de Configuração

### Cluster Simples
```hcl
instances = {
  primary = {
    instance_class = "db.t3.medium"
  }
}
```

### Cluster Multi-AZ
```hcl
instances = {
  primary = {
    instance_class = "db.r5.large"
    availability_zone = "us-west-2a"
    promotion_tier = 0
  }
  replica = {
    instance_class = "db.r5.large"
    availability_zone = "us-west-2b"
    promotion_tier = 1
  }
}
```

## Requisitos

- Terraform >= 1.0
- AWS Provider >= 5.0
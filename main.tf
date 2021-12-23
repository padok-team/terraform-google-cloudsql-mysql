# Official Google module for PostgreSQL: https://github.com/terraform-google-modules/terraform-google-sql-db/tree/master/modules/mysql

locals {
  read_replica_ip_configuration = {
    ipv4_enabled    = true
    require_ssl     = false
    private_network = null
    authorized_networks = [
      {
        name  = "db-${var.name}-cidr"
        value = var.ha_external_ip_range
      },
    ]
  }

  replicas = [
    for x in range(0, var.nb_replicas) : {
      name                = x
      tier                = "db-custom-${var.nb_cpu}-${var.ram}"
      zone                = var.zone
      disk_type           = "PD_HDD"
      disk_autoresize     = true
      disk_size           = var.disk_size
      user_labels         = {}
      database_flags      = []
      ip_configuration    = local.read_replica_ip_configuration
      encryption_key_name = null
    }
  ]

  our_users = [
    for x in range(0, length(var.list_user)) : {
      name      = var.list_user[x]
      password  = random_password.password[x].result
    }
  ]
}

resource "random_password" "password" {
  count            = length(var.list_user)
  length           = 16
  special          = true
  override_special = "_%@"
}

module "mysql-db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version = "8.0.0"

  name                 = var.name #mandatory
  database_version     = var.engine_version #mandatory
  project_id           = var.project_id #mandatory
  region               = var.region
  zone                 = var.zone #mandatory
  tier                 = "db-custom-${var.nb_cpu}-${var.ram}"

  db_charset           = var.db_charset
  db_collation         = var.db_collation

  # Storage
  disk_autoresize      = true
  disk_size            = var.disk_size
  disk_type            = "PD_SSD"

  # High Availability
  availability_type    = var.high_availability ? "REGIONAL" : "ZONAL"

  # Replicas
  read_replicas        = local.replicas

  # Users
  enable_default_user  = false
  additional_users     = local.our_users

  # Databases
  enable_default_db     = false
  additional_databases  = length(var.list_db) == 0 ? [] : var.list_db

  # Instance
  deletion_protection   = var.instance_deletion_protection

  ip_configuration = {
    ipv4_enabled = var.assign_public_ip
    # We never set authorized networks, we need all connections via the
    # public IP to be mediated by Cloud SQL.
    authorized_networks = []
    require_ssl         = var.require_ssl
    private_network     = var.private_network 
  }
}

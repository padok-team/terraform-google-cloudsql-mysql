# Here you can reference 2 type of terraform objects :
# 1. Ressources from you provider of choice
# 2. Modules from official repositories which include modules from the following github organizations
#     - AWS: https://github.com/terraform-aws-modules
#     - GCP: https://github.com/terraform-google-modules
#     - Azure: https://github.com/Azure

locals {
  read_replica_ip_configuration = {
    ipv4_enabled    = true
    require_ssl     = false
    private_network = null
    authorized_networks = [
      {
        name  = "${var.project_id}-cidr"
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
}

module "mysql-db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version = "8.0.0"

  name                 = var.name #mandatory
  database_version     = var.engine_version #mandatory
  project_id           = var.project_id #mandatory
  zone                 = var.zone #mandatory
  tier                 = "db-custom-${var.nb_cpu}-${var.ram}"

  db_collation        = "utf8_general_ci"

  # Storage
  disk_autoresize       = true
  disk_size             = var.disk_size
  disk_type             = "PD_SSD"

  # High Availability
  availability_type     = var.high_availability ? "REGIONAL" : "ZONAL"

  # Replicas
  read_replicas         = local.replicas
}

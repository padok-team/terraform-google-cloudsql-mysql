variable "name" {
  type        = string
  description = "The name of the Cloud SQL resource"
}

variable "project_id" {
  type        = string
  description = "The project ID to manage the Cloud SQL resource"
}

variable "zone" {
  type        = string
  description = "The zone for the master instance, it should be something like: us-central1-a, us-east1-c, etc."
}

variable "engine_version" {
  type        = string
  description = ""
  default     = "MYSQL_5_6"
}

variable "nb_cpu" {
  type        = number
  description = "Number of virtual processors"

  validation {
    condition     = var.nb_cpu == 1 || (var.nb_cpu >= 2 &&var.nb_cpu <= 96 && var.nb_cpu % 2 == 0) # https://cloud.google.com/sql/docs/postgres/create-instance#machine-types
    error_message = "Error: invalid number of CPU. Set an even number of processors between 2 and 96 (or 1)."
  }
}

variable "ram" {
  type        = number
  description = "Quantity of RAM (in Mb)"
}

variable "disk_size" {
  type        = number
  description = "Size of the db disk (in Gb)."
}

variable "high_availability" {
  type        = bool
  description = "Activate or not high availability for your DB"
  default     = true
}

variable "nb_replicas" {
  type        = number
  description = "Number of read replicas you need"
  default     = 0
}

variable "ha_external_ip_range" {
  type        = string
  description = "The ip range to allow connecting from/to Cloud SQL"
  default     = "192.10.10.10/32"
}
# variable "replicas" {
#   type        = list(object({
#     name            = string
#     tier            = string
#     zone            = string
#     disk_type       = string
#     disk_autoresize = bool
#     disk_size       = string
#     user_labels     = map(string)
#     database_flags  = list(object({
#       name  = string
#       value = string
#     }))
#     ip_configuration      = object({
#       authorized_networks = list(map(string))
#       ipv4_enabled        = bool
#       private_network     = string
#       require_ssl         = bool
#     })
#     encryption_key_name = string
#   }))
#   description = ""
# }

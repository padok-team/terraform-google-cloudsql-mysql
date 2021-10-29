# Short description of the use case in comments

# provider "xxx" {
# }

# module "use_case_2" {
#   source = "../.."

#   example_of_required_variable = "hello_use_case_2"
# }

module "test-mysql-db" {
  source                = "../.."
  
  name                  = "library-db" #mandatory
  #random_instance_name  = true
  engine_version        = "MYSQL_5_6" #mandatory
  project_id            = "library_db" #mandatory
  #region                = "europe-west1"
  zone                  = "europe-west1-b" #mandatory
  #tier                  = "db-n1-standard-1"

  nb_cpu                = 52
  ram                   = 7680

  disk_size             = 10

  nb_replicas           = 3
}

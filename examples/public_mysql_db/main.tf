# Short description of the use case in comments

# provider "xxx" {
# }

# module "use_case_2" {
#   source = "../.."

#   example_of_required_variable = "hello_use_case_2"
# }


module "test-mysql-db" {
  source                = "../.."
  
  name                  = "librarydb" #mandatory
  #random_instance_name  = true
  engine_version        = "MYSQL_5_6" #mandatory
  project_id            = "padok-lab" #mandatory
  region                = "europe-west1"
  zone                  = "europe-west1-b" #mandatory
  #tier                  = "db-n1-standard-1"

  nb_cpu                = 2
  ram                   = 4096

  disk_size             = 10

  nb_replicas           = 3

  list_user = ["Nico", "Robin"]

  list_db = [
    {
      name: "MYDB_1"
      charset: "utf8"
      collation: "utf8_general_ci"
    }
  ]
}

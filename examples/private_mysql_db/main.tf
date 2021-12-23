# Short description of the use case in comments

# provider "xxx" {
# }

# module "use_case_2" {
#   source = "../.."

#   example_of_required_variable = "hello_use_case_2"
# }

locals {
  project_id = "padok-cloud-factory"
}

provider "google" {
  project = local.project_id
  region  = "europe-west3"
}

provider "google-beta" {
  project = local.project_id
  region  = "europe-west3"
}

module "my_network" {
  source = "github.com/padok-team/terraform-google-network" 

  name = "my-network"
  subnets = {
    "my-private-subnet-1" = {
      cidr = "10.30.0.0/16"
      region = "europe-west3"
    }
  }
  peerings = {
    cloudsql = {
      address = "10.0.17.0"
      prefix = 24
    }
  }
}


module "test-mysql-db" {
  source = "../.."

  name = "padok-db" #mandatory
  #random_instance_name  = true
  engine_version = "MYSQL_5_6" #mandatory
  project_id     = local.project_id #mandatory
  region         = "europe-west1"
  zone           = "europe-west1-b" #mandatory
  #tier                  = "db-n1-standard-1"

  nb_cpu = 2
  ram    = 4096

  disk_size = 10

  nb_replicas = 3

  list_user = ["Nico", "Robin"]

  list_db = [
    {
      name : "MYDB_1"
      charset : "utf8"
      collation : "utf8_general_ci"
    }
  ]
  vpc_network = "default-europe-west1"

  private_network = module.my_network.id
}

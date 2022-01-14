# Google Cloud SQL (MySQL) Terraform module

Terraform module which creates **TYPE** resources on **CLOUD_PROVIDER**. This module is an abstraction of the [MODULE_NAME](https://github.com/a_great_module) by [@someoneverysmart](https://github.com/someoneverysmart).

## User Stories for this module

- AATYPE I can be highly available or single zone
- ...

## Usage

```hcl
module "example" {
  source = "https://github.com/padok-team/terraform-aws-example"

  example_of_required_variable = "hello_world"
}
```

## Examples

- [Example of use case](examples/example_of_use_case/main.tf)
- [Example of other use case](examples/example_of_other_use_case/main.tf)

<!-- BEGIN_TF_DOCS -->
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mysql-db"></a> [mysql-db](#module\_mysql-db) | GoogleCloudPlatform/sql-db/google//modules/mysql | 8.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Size of the db disk (in Gb). | `number` | n/a | yes |
| <a name="input_list_db"></a> [list\_db](#input\_list\_db) | List of the default DBs you want to create | <pre>list(object({<br>    name = string<br>    charset = string<br>    collation = string<br>  }))</pre> | n/a | yes |
| <a name="input_list_user"></a> [list\_user](#input\_list\_user) | List of the User's name you want to create (passwords will be auto-generated). | `list(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Cloud SQL resource. | `string` | n/a | yes |
| <a name="input_nb_cpu"></a> [nb\_cpu](#input\_nb\_cpu) | Number of virtual processors | `number` | n/a | yes |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | n/a | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to manage the Cloud SQL resource. | `string` | n/a | yes |
| <a name="input_ram"></a> [ram](#input\_ram) | Quantity of RAM (in Mb) | `number` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region for the master instance, it should be something like: us-central1-a, us-east1-c, etc. | `string` | n/a | yes |
| <a name="input_vpc_network"></a> [vpc\_network](#input\_vpc\_network) | Name of the VPC within the instance SQL is deployed. | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone for the master instance, it should be something like: us-central1-a, us-east1-c, etc. | `string` | n/a | yes |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Set to true if the master instance should also have a public IP (less secure). | `bool` | `false` | no |
| <a name="input_db_charset"></a> [db\_charset](#input\_db\_charset) | Charset for the DB. | `string` | `"utf8"` | no |
| <a name="input_db_collation"></a> [db\_collation](#input\_db\_collation) | Collation for the DB. | `string` | `"utf8_general_ci"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | n/a | `string` | `"MYSQL_5_6"` | no |
| <a name="input_ha_external_ip_range"></a> [ha\_external\_ip\_range](#input\_ha\_external\_ip\_range) | The ip range to allow connecting from/to Cloud SQL. | `string` | `"192.10.10.10/32"` | no |
| <a name="input_high_availability"></a> [high\_availability](#input\_high\_availability) | Activate or not high availability for your DB. | `bool` | `true` | no |
| <a name="input_instance_deletion_protection"></a> [instance\_deletion\_protection](#input\_instance\_deletion\_protection) | Used to block Terraform from deleting a SQL Instance. | `bool` | `false` | no |
| <a name="input_nb_replicas"></a> [nb\_replicas](#input\_nb\_replicas) | Number of read replicas you need. | `number` | `0` | no |
| <a name="input_require_ssl"></a> [require\_ssl](#input\_require\_ssl) | Set to false if you don not want to enforece SSL  (less secure). | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_users"></a> [additional\_users](#output\_additional\_users) | List of maps of additional users and passwords. |
| <a name="output_instance_connection_name"></a> [instance\_connection\_name](#output\_instance\_connection\_name) | The connection name of the master instance to be used in connection strings. |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | The instance name for the master instance. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The first private (PRIVATE) IPv4 address assigned for the master instance. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The first public (PRIMARY) IPv4 address assigned for the master instance. |
| <a name="output_read_replica_instance_names"></a> [read\_replica\_instance\_names](#output\_read\_replica\_instance\_names) | The instance names for the read replica instances. |
<!-- END_TF_DOCS -->

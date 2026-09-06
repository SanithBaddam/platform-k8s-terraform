variable "name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "dns_prefix" { type = string }
variable "subnet_id" { type = string }
variable "log_analytics_workspace_id" { type = string }
variable "kubernetes_version" { type = string default = null }
variable "system_node_count" { type = number default = 2 }
variable "tags" { type = map(string) default = {} }

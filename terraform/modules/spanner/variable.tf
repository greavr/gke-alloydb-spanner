# SpannerDB
variable "project_id" {}
variable "network_name" {}
variable "region" {}
variable "user_name" {
  default="spanner_user"
}
variable "database_name" {
  default="my-database"
}
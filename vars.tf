variable "location" {
  type    = string
  default = "westeurope"
}
variable "prefix" {
  type    = string
  default = "azterraform"
}

variable "ssh-source-address" {
  type    = string
  default = "*"
}

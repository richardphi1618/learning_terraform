variable "location" {
  type    = string
  default = "East US"
}

variable "loc_short" {
  type    = string
  default = "EUS"
}

variable "app_name" {
  type    = string
  default = "tftesting"
}

variable "tags" {
  type = map(string)
  default = {
    CostCenter  = "DataOps"
    Owner       = "Richard Blanchette"
    User        = "Richard Blanchette"
    Enviornment = "Dev"
  }
}

variable "vm_size" {
  type    = string
  default = "Standard_B2s"
}

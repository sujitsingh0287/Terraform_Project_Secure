variable "rg_name" {
    type = string
  
}

variable "location" {
    type = string
  
}

variable "new_vm" {
    type = string
  
}

variable "subnet_id" {
  type = string
}

variable "admin_username" {
    type = string
}

variable "admin_password" {
    type = string
    sensitive = true
  
}

  

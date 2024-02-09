###cloud vars
# variable "token" {
#   type        = string
#   description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
# }
variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number }))
    default = [
    {
      vm_name     = "main"
      cpu         = 2
      ram         = 2
      disk_volume = 10
    },
    {
      vm_name     = "replica"
      cpu         = 2
      ram         = 1
      disk_volume = 15
    }
  ]
}


variable "vms_resources" {
  type = map(object({cores = number, memory = number, core_fraction = number}))
  default = {
  #     example       var.vms_resources.web.cores 
    web = {
    cores = 2
    memory = 1
    core_fraction = 5
  } 
  #     example      var.vms_resources.vm_db.cores
  #   vm_db = {
  #   cores = 2
  #   memory = 2
  #   core_fraction = 20
  # }
  }
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  default     = ""
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  default     = ""
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_web_platform_preemptible"{
  type        =  bool
  default     =  true 
  description = "могут быть прерваны по решению облачного провайдера без предупреждения.(до 24 часов)" 
}

variable "vm_web_platform_network_interface_nat"{
  type        =  bool
  default     =  true 
  description = "interface_nat true or false" 
}

variable "vm_web_platform_name"{
  type        =  string
  default     = "netology-develop-platform-web"
  description = "platform_name"
}

variable "vm_web_platform_id"{
  type        =  string
  default     = "standard-v2"
  description = "https://cloud.yandex.ru/ru/docs/compute/concepts/vm-platforms"
}

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "https://cloud.yandex.ru/ru/marketplace?categories=os"
}

variable "new_platform_body_name" {
  type        = string
  description = "new_platform_name"
  default     = "netology-develop-platform"
}
variable "new_platform_web_name" {
  type        = string
  description = "new_platform_web_name"
  default     = "web"
}
variable "new_platform_db_name" {
  type        = string
  description = "new_platform_db_name"
  default     = "db"
}
variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2  # Установите значение по умолчанию или измените его по своему усмотрению
}

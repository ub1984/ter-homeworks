#######################  https://terraform-provider.yandexcloud.net/Resources/compute_instance     ###############################


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

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  default     = "b1g1iv6o0hhtg6um2si5"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  default     = "b1g1iv6o0hhtg6um2si5"
}

#hw
variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "https://cloud.yandex.ru/ru/marketplace?categories=os"
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
  description = "VPC network & subnet name"
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
variable "vm_web_platform_metadata_serial_port_enable"{
  type        =  bool
  default     =  true 
  description = "serial_port_enable true or false" 
}
/*
variable "vm_web_platform_cores"{
  type        =  number
  default     =  2
  description = "https://cloud.yandex.ru/ru/docs/compute/concepts/vm-platforms" 
}

variable "vm_web_platform_memory"{
  type        =  number
  default     =  1
  description = "https://cloud.yandex.ru/ru/docs/compute/concepts/vm-platforms" 
}

variable "vm_web_platform_core_fraction"{
  type        =  number
  default     =  5
  description = "позволяет задать % долю выделенного процессорного времени для виртуальной машины" 
}

variable "vm_db_vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 XXXXXXX"
  description = "ssh-keygen -t ed25519"
  sensitive   = true
}

variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
  #default     = "ru-central1-a"
}

variable  "ssh_metadata" {
  type = map(string)
  default = {
    serial-port-enable = "true"
    ssh-keys           = "ubuntu:ssh-key XXXXXXXXXXXXXXXXXXXXXXXXXXXX ub@ub"
  }
}
*/






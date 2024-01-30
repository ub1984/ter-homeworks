#######################  https://terraform-provider.yandexcloud.net/Resources/compute_instance     ###############################
###vm_db_cloud vars
# variable "token" {
#   type        = string
#   description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
#   #default     = "ru-central1-a"
# }

# variable "vm_db_cloud_id" {
#   type        = string
#   description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
#   default     = "b1g1iv6o0hhtg6um2si5"
# }

# variable "vm_db_folder_id" {
#   type        = string
#   description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
#   default     = "b1g1iv6o0hhtg6um2si5"
# }
#hw

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
    vm_db = {
    cores = 2
    memory = 2
    core_fraction = 20
  }
  }
}

variable "vm_db_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "https://cloud.yandex.ru/ru/marketplace?categories=os"
}

variable "vm_db_default_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "vm_db_default_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_vpc_name" {
  type        = string
  default     = "develop2"
  description = "VPC network & subnet name"
}

variable "vm_db_platform_name"{
  type        =  string
  default     = "netology-develop-platform-db"
  description = "platform_name"
}

variable "vm_db_platform_id"{
  type        =  string
  default     = "standard-v2"
  description = "https://cloud.yandex.ru/ru/docs/compute/concepts/vm-platforms"
}
/*
variable "vm_db_platform_cores"{
  type        =  number
  default     =  2
  description = "https://cloud.yandex.ru/ru/docs/compute/concepts/vm-platforms" 
}

variable "vm_db_platform_memory"{
  type        =  number
  default     =  2
  description = "https://cloud.yandex.ru/ru/docs/compute/concepts/vm-platforms" 
}

variable "vm_db_platform_core_fraction"{
  type        =  number
  default     =  20
  description = "позволяет задать % долю выделенного процессорного времени для виртуальной машины" 
}
*/
variable "vm_db_platform_preemptible"{
  type        =  bool
  default     =  true 
  description = "могут быть прерваны по решению облачного провайдера без предупреждения.(до 24 часов)" 
}

variable "vm_db_platform_network_interface_nat"{
  type        =  bool
  default     =  true 
  description = "interface_nat true or false" 
}
variable "vm_db_platform_metadata_serial_port_enable"{
  type        =  bool
  default     =  true 
  description = "serial_port_enable true or false" 
}

resource "yandex_vpc_subnet" "test" {
  name           = var.vm_db_vpc_name
  zone           = var.vm_db_default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_default_cidr
}


resource "yandex_compute_instance" "vm_db_platform" {
  name        = local.db_platform_name 
  platform_id = var.vm_db_platform_id 
  zone        = var.vm_db_default_zone 
  resources {
    cores         = var.vms_resources.vm_db.cores 
    memory        = var.vms_resources.vm_db.memory 
    core_fraction = var.vms_resources.vm_db.core_fraction # позволяет задать % долю выделенного процессорного времени для виртуальной машины.
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  
  scheduling_policy {
    preemptible = var.vm_db_platform_preemptible # могут быть прерваны по решению облачного провайдера без предупреждения.(до 24 часов)
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.test.id
    nat       = var.vm_db_platform_network_interface_nat
  }

  metadata = {   
    serial-port-enable = var.ssh_metadata.serial-port-enable  
    ssh-keys           = var.ssh_metadata.ssh-keys
  }

  # metadata = {   
  #   serial-port-enable = var.vm_db_platform_metadata_serial_port_enable    
  #   ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"   
  #   }

}
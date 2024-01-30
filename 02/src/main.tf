resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu" {  
  family = var.vm_web_image
}

resource "yandex_compute_instance" "platform" {
  name        = local.web_platform_name 
  platform_id = var.vm_web_platform_id 
  resources { 
    cores         = var.vms_resources.web.cores 
    memory        = var.vms_resources.web.memory 
    core_fraction = var.vms_resources.web.core_fraction # позволяет задать % долю выделенного процессорного времени для виртуальной машины.
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  
  scheduling_policy {
    preemptible = var.vm_web_platform_preemptible # могут быть прерваны по решению облачного провайдера без предупреждения.(до 24 часов)
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_platform_network_interface_nat
  }

  metadata = {   
    serial-port-enable = var.ssh_metadata.serial-port-enable  
    ssh-keys           = var.ssh_metadata.ssh-keys
  }


}

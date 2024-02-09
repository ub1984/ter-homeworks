# disk_vm.tf

# Создаем виртуальные диски
resource "yandex_compute_disk" "storage_disk" {
  count     = 3
  name      = "storage-disk-${count.index + 1}"
  size      = 1
}

# Создаем виртуальную машину с одним основным диском и тремя дополнительными дисками
resource "yandex_compute_instance" "storage" {
  name         = "storage"
  platform_id  = var.vm_web_platform_id
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
    #security_group_ids = [yandex_vpc_security_group.example.id] # привязка группы безопасности < security.tf
  }
    metadata = {   
    serial-port-enable = var.ssh_metadata.serial-port-enable  
    ssh-keys           = var.ssh_metadata.ssh-keys
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk
    content {
      device_name = "secondary-disk-${secondary_disk.key}"
      disk_id     = secondary_disk.value.id
    }
  }
}

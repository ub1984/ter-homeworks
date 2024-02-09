resource "yandex_compute_instance" "database" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  name = "database-${each.key}"
  platform_id = var.vm_web_platform_id 
    resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = var.vms_resources.web.core_fraction
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

}

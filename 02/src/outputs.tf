####################### используется для вывода значений из ресурсов, созданных в проекте Terraform ###########

output "vm_db_platform_nat_ip_address" {
  value = [[yandex_compute_instance.vm_db_platform.network_interface[0].nat_ip_address, yandex_compute_instance.vm_db_platform.fqdn, yandex_compute_instance.vm_db_platform.name],
  [yandex_compute_instance.platform.network_interface[0].nat_ip_address, yandex_compute_instance.platform.fqdn, yandex_compute_instance.platform.name]]  
}
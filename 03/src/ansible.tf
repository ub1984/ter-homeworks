
resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = [
      for instance in yandex_compute_instance.web[*] : {
        name = "web-${instance.id}"
        nat_ip_address = instance.network_interface[0].nat_ip_address
        fqdn = instance.fqdn
      }
    ], 
    databases = [
      for instance in yandex_compute_instance.database : {
        name = "database-${instance.id}"
        nat_ip_address = instance.network_interface[0].nat_ip_address
        fqdn = instance.fqdn
      }
    ],
    storage = [
      for instance in yandex_compute_instance.storage[*] : {
        name = "storage-${instance.id}"
        nat_ip_address = instance.network_interface[0].nat_ip_address
        fqdn = instance.fqdn
      }
    ]
  })
  filename = "${abspath(path.module)}/hosts.cfg"
}

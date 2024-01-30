 locals {
   db_platform_name = "${var.new_platform_body_name}-${var.new_platform_db_name}"
   web_platform_name = "${var.new_platform_body_name}-${var.new_platform_web_name}"
 }

# locals {
#   type = map(object({serial-port-enable = bool, ssh-keys = string }))
#   default = {serial-port-enable = true, ssh-keys = var.vms_ssh_root_key}
# }

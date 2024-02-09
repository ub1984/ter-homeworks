
locals {
  web_platform_names = [for i in range(0, var.instance_count): "${var.new_platform_body_name}-${var.new_platform_web_name}-${i + 1}"]
}




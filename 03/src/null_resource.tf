resource "null_resource" "web_hosts_provision" {
  # Ждем создания инстанса
  depends_on = [yandex_compute_instance.web,yandex_compute_instance.database,yandex_compute_instance.storage]

  # Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    command = "cat ~/.ssh/id_ed25519 | ssh-add -"
  }

  # Костыль!!! Даем ВМ 60 сек на первый запуск. Лучше выполнить это через wait_for port 22 на стороне ansible
  # В случае использования cloud-init может потребоваться еще больше времени
  provisioner "local-exec" {
    command = "sleep 60"
  }

  # Запуск ansible-playbook
  provisioner "local-exec" {
    command     = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml"
    on_failure  = continue # Продолжить выполнение terraform pipeline в случае ошибок
    environment = { 
      ANSIBLE_HOST_KEY_CHECKING = "False" 
      SSH_ASKPASS = "/usr/bin/ssh-askpass" } # Указывает путь к ssh-askpass
    # срабатывание триггера при изменении переменных
  }

  triggers = {
    always_run        = "${timestamp()}"                         # всегда т.к. дата и время постоянно изменяются
    playbook_src_hash = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
    ssh_public_key    = var.ssh_metadata.ssh-keys                           # при изменении переменной
  }
}

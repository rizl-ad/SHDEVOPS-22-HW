resource "null_resource" "web_provision" {
  depends_on = [yandex_compute_instance.web, yandex_compute_instance.db, yandex_compute_instance.storage]

  provisioner "local-exec" {
    command = "ansible-playbook -i ${local_file.hosts.filename} -T 60 ${local_file.test_v2_yaml.filename} --private-key ~/.ssh/ssh-key"
    on_failure  = continue
  }
}

resource "local_file" "test_v2_yaml" {
  content = <<-EOF
    ---
    - name: test
      gather_facts: false
      hosts: webservers
      vars:
        ansible_ssh_user: ${var.vm_user_name}
      become: yes

      tasks:
        - name: save own secret
          copy:
            dest: /tmp/own.pass
            content: "{{ secrets[inventory_hostname]  }}"
          when: secrets[inventory_hostname] is defined

        - name: save all secrets
          copy:
            dest: /tmp/all.pass
            content: "{{ secrets }}"
          when: secrets is defined
  EOF
  filename = "test_v2.yaml"
}

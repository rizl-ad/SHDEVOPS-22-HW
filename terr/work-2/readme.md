# Решение ДЗ к занятию «Основы Terraform. Yandex Cloud»

## Задача 1
### п. 4
Ошибки при выполнении проекта:
1. `platform_id = "standart-v2"` в ресурсе "yandex_compute_instance.platform" - строка содержит две ошибки: платформы "v4" не существует и правильное написание идентификатора платформы "standard" - "d" на конце.
2. `cores = 1` в ресурсе "yandex_compute_instance.platform" - допустимы значения кратные 2.
3. `core_fraction = 5` в ресурсе "yandex_compute_instance.platform" - значение 5% допустимо только на платформах "standard-v1" и "standard-v2".
4. `ssh-keys = "ubuntu:${var.vms_ssh_root_key}"` - в ВМ необходимо передать открытый, а не закрытый ключ, т.е. необходимо указать переменную `vms_ssh_public_root_key`.

### п. 6
Параметры `preemptible = true` и `core_fraction=5` позволяют минимизируют затраты на ВМ в процессе обучения. 

### Итог:
<img width="349" height="320" alt="t1_p5" src="https://github.com/user-attachments/assets/f015be56-a009-4570-bdee-87425498dfa9" />

<img width="1230" height="149" alt="t1_1" src="https://github.com/user-attachments/assets/cf9086c9-461c-4763-baf9-526344adb6f9" />

## Задача 2

<img width="449" height="377" alt="t1_1" src="https://github.com/user-attachments/assets/b8ca374f-b7b0-4c96-89fd-34fe964e8380" />

## Задача 3

## Задача 4

## Задача 5

## Задача 6

## Задача 7

## Задача 8

## Задача 9

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
<img width="349" height="320" alt="t1_p5" src="https://github.com/user-attachments/assets/f015be56-a009-4570-bdee-87425498dfa9" /><br>
<img width="1230" height="149" alt="t1_1" src="https://github.com/user-attachments/assets/cf9086c9-461c-4763-baf9-526344adb6f9" />

## Задача 2

<img width="449" height="377" alt="t1_1" src="https://github.com/user-attachments/assets/b8ca374f-b7b0-4c96-89fd-34fe964e8380" />

## Задача 3
Для размещения второй ВМ в зоне "ru-central1-b" в ресурс "yandex_vpc_subnet.develop" добавлена строка `count = 2` переменные `pc_subnet_name` И `default_zone` объявлены как списки с добавлением значений для зоны "b", перемнная `var.default_cidr` объявлена как список из списков с добалением CIDR для подсети в зоне "b".

<img width="1228" height="175" alt="t3_1" src="https://github.com/user-attachments/assets/e9b677a3-0d18-495a-ada0-a9507ab74503" /><br>
<img width="867" height="318" alt="t3_2" src="https://github.com/user-attachments/assets/dd227c98-b090-467b-8610-5b4e98ef7999" />

## Задача 4
На совсем понял что значит фраза "(без хардкода!!!)" - создание ВМ мы захардкодили - объявили двумя ресурсами - поэтому output по ним также придется хардкодить, т.е. указывать для каждой ВМ отдельные строки.

Вывод ip-адресов:

<img width="315" height="45" alt="t4_1" src="https://github.com/user-attachments/assets/6649eeba-91e9-4536-83e3-471188273060" />

## Задача 5
<img width="275" height="44" alt="t5_0" src="https://github.com/user-attachments/assets/cbc0c5de-8374-4329-a39c-4c2263091995" /><br>
<img width="567" height="692" alt="t5_1" src="https://github.com/user-attachments/assets/b26379c1-4bd7-4892-8716-38efe0fc20d1" /><br>
<img width="1234" height="177" alt="t5_2" src="https://github.com/user-attachments/assets/c0029135-138b-4c79-bd4a-1ddf126d06e6" />

## Задача 6
<img width="517" height="480" alt="t6_1" src="https://github.com/user-attachments/assets/61dfdbf6-3ab1-417e-8583-27edc463d297" />

## Задача 7
<img width="775" height="101" alt="t7_1" src="https://github.com/user-attachments/assets/dffb682d-ca25-4e6b-a59b-398e641785e7" />

## Задача 8
### п. 1
terraform console определяет тип перменной как tuple(object(tuple(string,string)))  
<img width="252" height="203" alt="t8_1" src="https://github.com/user-attachments/assets/ac6d9a9f-1d7b-413f-babd-043ba6cd88b8" />

### п. 2
<img width="251" height="43" alt="t8_2" src="https://github.com/user-attachments/assets/249c3654-3118-4594-9fdf-3d399a813d0c" />

## Задача 9

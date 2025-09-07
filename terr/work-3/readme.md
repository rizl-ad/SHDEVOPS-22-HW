# Решение ДЗ к занятию «Управляющие конструкции в коде Terraform»

## Задача 1

<img width="409" height="315" alt="t1_1" src="https://github.com/user-attachments/assets/50dc7775-0564-473d-a2d1-ec2f42452368" />

## Задачи 2-4
Сымпровизировал по типу переменной для задания параметров ВМ. Можно было оставить `list(object({...}))`, но в моем варианте индекс главного типа `list()` при обращении к переменной был бы лишним.

Скрин inventory-файла:  
<img width="501" height="122" alt="t2-4_1" src="https://github.com/user-attachments/assets/946bebfd-1e1c-4aad-8e1c-6eba067b5ebc" />


Ссылка на commit: https://github.com/rizl-ad/SHDEVOPS-22-HW/commit/b13217c4fe9bc4993ab6310f2a0796d20a5d0cd8

## Задача 5
<img width="275" height="408" alt="t5_2" src="https://github.com/user-attachments/assets/a4333c77-6d41-4c1b-b8b1-78a8fda02632" />

## Задача 6
Результат отработки ansible-playbook:  
<img width="646" height="184" alt="t6_1" src="https://github.com/user-attachments/assets/3468dbcd-5901-41da-b8c0-17958ddfb910" />


Файл `hosts.ini` после доработки шаблона (оставил публичные адреса у `webserwers`, у остальных отключил):
<img width="483" height="111" alt="t6_2" src="https://github.com/user-attachments/assets/564c1100-8c5a-44d0-8dae-d08539bd104b" />


Код проекта: https://github.com/rizl-ad/SHDEVOPS-22-HW/tree/main/terr/work-3

## Задача 7
Выражение:  
```
merge(local.vpc, {
  subnet_ids = concat(slice(local.vpc.subnet_ids, 0, 2), slice(local.vpc.subnet_ids, 3, length(local.vpc.subnet_ids))),
  subnet_zones = concat(slice(local.vpc.subnet_zones, 0, 2), slice(local.vpc.subnet_zones, 3, length(local.vpc.subnet_zones)))
})
```

<img width="566" height="289" alt="t7_1" src="https://github.com/user-attachments/assets/6f860262-afa6-469f-87e8-6d7c1f33ea3d" />

## Задача 8
1. Неверно расставлены фигурные скобки в 3-ей строке- необходимо перенести скобку из конца строки в позицию после выражения обращения к публичному ip-адресу.
2. Аргумент "platform_id " не существует - ошибочно добавлен пробел в конце имени аргумента

Верный код:
```
[webservers]
%{~ for i in webservers ~}
${i["name"]} ansible_host=${i["network_interface"][0]["nat_ip_address"]} platform_id=${i["platform_id"]}
%{~ endfor ~}
```

## Задача 9
### п. 1
1. `[ for i in range(1,100) : i > 9 ? "rc${i}" : "rc0${i}" ]`
2. `[ for i in range(1,100) : format("rc%02d", i) ]`

### п. 2
1. `[ for i in range(1, 97) : i > 9 ? "rc${i}" : "rc0${i}" if !contains(["0","7","8","9"], substr(i, -1, -1)) || i == 19 ]`
2. `[ for i in range(1, 97) : format("rc%02d", i) if !contains([0, 7, 8, 9], i % 10) || i == 19 ]`

# Решение [ДЗ к занятию «Кластеры. Ресурсы под управлением облачных провайдеров»](https://github.com/netology-code/clopro-homeworks/blob/main/15.4.md)

## Задание 1. Yandex Cloud

[Terraform-проект](https://github.com/rizl-ad/SHDEVOPS-22-HW/tree/main/cloud/work-4/terraform)

### п. 1

Кластер БД соответствует требованиям:
- отказоустойчивый MySQL-кластер с узлами размещенными в разных private зонах и разных подсетях;
- репликация с произвольным временем технического обслуживания;
- окружение Prestable, платформа Intel Broadwell с производительностью 50% CPU и размером диска 20 Гб;
- время начала резервного копирования в интервале 23:00 - 24:00;
- защита от непреднамеренного удаления;
- БД с именем netology_db, логином и паролем.

<img width="498" height="696" alt="p1_1" src="https://github.com/user-attachments/assets/bc715ee1-de47-41fd-81b8-356e553bd0cc" /><br>
<img width="822" height="200" alt="p1_2" src="https://github.com/user-attachments/assets/dd3fd23a-e92d-47d6-9410-767089e16626" /><br>
<img width="495" height="176" alt="p1_3" src="https://github.com/user-attachments/assets/cde570f8-b07b-43cf-90c3-0d83855d64d3" /><br>
<img width="882" height="191" alt="p1_4" src="https://github.com/user-attachments/assets/b7bd052d-7a09-4fad-a30a-4abcff9cbf7a" />

### п. 2

Кластер Kubernetes соответствует требованиям:
- региональный K8s-кластер с master-нодами размещенными в разных private зонах и разных подсетях;
- отдельный сервис-аккаунт с необходимыми правами;
- шифрование KMS-ключом;
- worker-группа из трёх нод с автомасштабированием до шести.

<img width="865" height="183" alt="p2_1" src="https://github.com/user-attachments/assets/752dae1d-e155-4525-9eab-a5f3568a9dd5" /><br>
<img width="501" height="694" alt="p2_2" src="https://github.com/user-attachments/assets/a7ce9909-2924-4645-9b37-20ab2ee86b3d" /><br>
<img width="565" height="697" alt="p2_3" src="https://github.com/user-attachments/assets/c06cfc36-7b00-465b-9805-77df6ad5d342" /><br>
<img width="820" height="205" alt="p2_4" src="https://github.com/user-attachments/assets/ce81ae81-0041-42ba-8502-edd8072f3a29" /><br>
<img width="1134" height="253" alt="p2_5" src="https://github.com/user-attachments/assets/fb23110f-afb4-48a3-9e07-4a74ae895cba" /><br>
<img width="564" height="450" alt="p2_6" src="https://github.com/user-attachments/assets/e62fa8dd-f67b-400a-8361-67242057798c" />

Микросервис phpmyadmin с сервисом типа Load Balancer:   
<img width="501" height="139" alt="p2_7" src="https://github.com/user-attachments/assets/782407be-6b3c-4188-86f9-9931989e7210" /><br>
<img width="389" height="70" alt="p2_8" src="https://github.com/user-attachments/assets/d6465281-d133-496a-8d49-78fd231da23d" />

Подключение к phpmyadmin по публичному адресу, подключение к БД:   
<img width="712" height="260" alt="p2_9" src="https://github.com/user-attachments/assets/e6fb9eb3-3c90-4664-9815-0a981cc6eb41" />

Для убедительности наличия валидных учетных данных вручную создана таблица в БД:   
<img width="697" height="359" alt="p2_10" src="https://github.com/user-attachments/assets/c59d7aa4-10fe-4ad5-8a20-5592412ce6a0" />


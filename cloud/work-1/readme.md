# Решение [ДЗ к занятию «Организация сети»](https://github.com/netology-code/clopro-homeworks/blob/main/15.1.md)

## Задание 1. Yandex Cloud

[Terraform-проект](https://github.com/rizl-ad/SHDEVOPS-22-HW/tree/main/cloud/work-1/t1)

`terraform apply`:   
<img width="445" height="248" alt="t1_1" src="https://github.com/user-attachments/assets/51535aa4-da42-4edf-a1ea-68c9487d591e" />

<img width="922" height="167" alt="t1_5" src="https://github.com/user-attachments/assets/ca618100-a8aa-440e-b195-9616aecd8af8" />

<img width="969" height="255" alt="t1_6" src="https://github.com/user-attachments/assets/312ea693-bb82-4ab9-8fec-5bd12062a223" />

<img width="986" height="172" alt="t1_7" src="https://github.com/user-attachments/assets/f0170668-3038-47f3-94b6-96bcf0edbd0d" />

<img width="934" height="174" alt="t1_8" src="https://github.com/user-attachments/assets/2fa50d50-a2ab-4a02-b4ac-542def852ca0" />

<img width="538" height="277" alt="t1_9" src="https://github.com/user-attachments/assets/fdafb673-b5cf-48c1-8e95-3fdec38d89e9" />

Подключение к public-вм, проверка доступности Интернет:   
<img width="345" height="453" alt="t1_2" src="https://github.com/user-attachments/assets/4229f52c-2c9d-4d88-a1b0-4211a9c1288b" />

Подключение к private-вм через public-вм, проверка доступности Интернет (по маршруту через NAT-instance):   
<img width="386" height="472" alt="t1_3" src="https://github.com/user-attachments/assets/4e66a9aa-891f-4144-83d8-b4f89755c7dc" />

Для NAT-instance создана группа безопасности `nat` с правилом для входящего трафика, разрешающим подключение только из сетей VPC.   
Попытка подключения к NAT-instance извне:   
<img width="307" height="29" alt="t1_4" src="https://github.com/user-attachments/assets/8ca314f7-cf08-4c32-9dea-cb0a434b13d0" />

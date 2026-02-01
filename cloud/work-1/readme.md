# Решение [ДЗ к занятию «Организация сети»](https://github.com/netology-code/clopro-homeworks/blob/main/15.1.md)

## Задание 1. Yandex Cloud

[Terraform-проект](https://github.com/rizl-ad/SHDEVOPS-22-HW/tree/main/cloud/work-1/t1)

`terraform apply`:   
<img width="445" height="248" alt="t1_1" src="https://github.com/user-attachments/assets/51535aa4-da42-4edf-a1ea-68c9487d591e" />

Подключение к public-вм, проверка доступности Интернет:   
<img width="345" height="453" alt="t1_2" src="https://github.com/user-attachments/assets/4229f52c-2c9d-4d88-a1b0-4211a9c1288b" />

Подключение к private-вм через public-вм, проверка доступности Интернет (через route table):   
<img width="386" height="472" alt="t1_3" src="https://github.com/user-attachments/assets/4e66a9aa-891f-4144-83d8-b4f89755c7dc" />

Для NAT-instance создана группа безопасности `nat` с правилом для входящего трафика, разрешающим подключение только из сетей VPC.   
Попытка подключения к NAT-instance извне:   
<img width="307" height="29" alt="t1_4" src="https://github.com/user-attachments/assets/8ca314f7-cf08-4c32-9dea-cb0a434b13d0" />

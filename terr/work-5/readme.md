# Решение ДЗ к занятию «Использование Terraform в команде»
## Задача 1
### по коду ДЗ к лекции 4:

#### TFLint:
<img width="532" height="291" alt="t1_1" src="https://github.com/user-attachments/assets/323d7743-cb8c-4bdc-8123-4cce01a85700" />

Одно предупреждение об отсутствуии ограничения версии для провайдера.   
Остальные три об объявленных, но не используемых переменных.

#### Chekov:
<img width="598" height="142" alt="t1_4" src="https://github.com/user-attachments/assets/09f2c686-b083-4a5c-8c5e-15e0d0c4966c" />

Нет предупреждений и ошибок.

### по коду демо к лекции 4:

#### TFLint модуля passwords:
<img width="530" height="97" alt="t1_2" src="https://github.com/user-attachments/assets/2ce2be73-fdf0-4f53-9e19-9e115dc974d4" />

Предупреждение об отсутствуии ограничения версии для провайдера.

#### TFLint модуля vms:
<img width="661" height="350" alt="t1_3" src="https://github.com/user-attachments/assets/b15ff1a2-1c22-4e64-ac30-7890b4b61967" />

Два предупреждения о том, что модуль берётся из репозитория "git::https://github.com/..." с использованием ветки по умолчанию - main - без явного указания ветки или тега.   
Одно предупреждение об отсутствуии ограничения версии для провайдера.   
Одна об объявленной, но не используемой переменной.

#### Chekov модуля passwords:
<img width="637" height="139" alt="t1_5" src="https://github.com/user-attachments/assets/04dc2f6d-5c0d-4446-9e2d-60f62ab56e71" />

Нет предупреждений и ошибок.

#### Chekov модуля vms:
<img width="446" height="484" alt="t1_6" src="https://github.com/user-attachments/assets/041f5109-a036-4f28-a406-83f2fbbf1443" />
<img width="452" height="509" alt="t1_7" src="https://github.com/user-attachments/assets/2a57b958-9584-4ac0-825e-3d2cbfd2d0f0" />
<img width="455" height="395" alt="t1_8" src="https://github.com/user-attachments/assets/89c61462-2a37-4b84-9b13-370ac24a21d1" />

Для каждой ВМ рекомендация - убедиться что на ВМ отключена серийная консоль управления.

Для каждой ВМ не пройденные проверки информационной безопасности:
- убедиться, что сетевому интерфейсу назначена группа безопасности.
- убедиться, что ВМ не назначен ip-адрес.

Для каждого модуля ВМ не пройденные проверки версионирования:
- убедитесь, что источники модуля terraform используют хэш коммита.
- убедитесь, что источники модуля terraform используют тег с номером версии.

## Задача 2
### п. 2
Bucket создан в 6-ом задии ДЗ 4:   
<img width="460" height="113" alt="t2_1" src="https://github.com/user-attachments/assets/935c1554-8911-4895-a035-9d4d5ddfbea0" />

Настройки bucket:   
<img width="482" height="185" alt="t2_2" src="https://github.com/user-attachments/assets/21939c69-2183-4e46-b84c-af70064f5353" />
<img width="597" height="300" alt="t2_3" src="https://github.com/user-attachments/assets/6418cf7e-31a7-4382-84d6-fdddf82cf93d" />
<img width="542" height="185" alt="t2_4" src="https://github.com/user-attachments/assets/18ecab9d-ac78-4911-87de-bbc7205dc059" />

БД YDB:   
<img width="787" height="108" alt="t2_5" src="https://github.com/user-attachments/assets/4f7e1d3b-3f92-4230-a445-8775cf99d6a5" />

Таблица:   
<img width="506" height="201" alt="t2_6" src="https://github.com/user-attachments/assets/d0e2552e-3d95-4fb3-b418-73d74dc0906d" />

Terraform backend:   
<img width="687" height="210" alt="t2_7" src="https://github.com/user-attachments/assets/5e78ce70-ef99-4bb5-b234-49df40d93705" />
<img width="387" height="247" alt="t2_8" src="https://github.com/user-attachments/assets/41377616-e878-4959-911f-5a45458d2b9a" />

### п. 3
Код: https://github.com/rizl-ad/SHDEVOPS-22-HW/tree/main/terr/work-5/t2

### п. 4-6
<img width="714" height="325" alt="t2_9" src="https://github.com/user-attachments/assets/781723ca-82ed-42c8-83c8-1c7d14204f53" />
<img width="716" height="102" alt="t2_10" src="https://github.com/user-attachments/assets/c44e33e8-3808-425d-b6cb-c23bd9fae304" />

#### 

## Задача 3

## Задача 4

## Задача 5

## Задача 6

## Задача 7

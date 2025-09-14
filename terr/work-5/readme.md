# Решение ДЗ к занятию «Использование Terraform в команде»
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


## Задача 1

## Задача 2

## Задача 3

## Задача 4

## Задача 5

## Задача 6

## Задача 7

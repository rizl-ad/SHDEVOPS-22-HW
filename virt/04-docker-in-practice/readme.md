# Рещение ДЗ к занятию 5 «Практическое применение Docker»
## Задача 0

<img width="699" height="330" alt="w0" src="https://github.com/user-attachments/assets/e1bb4c19-cbbb-4d12-8850-1ebd652ba5eb" />


## Задача 1
### п. 1

Fork: https://github.com/rizl-ad/shvirtd-example-python/tree/main

### п. 2

`Dockerfile.python`: https://github.com/rizl-ad/shvirtd-example-python/blob/main/Dockerfile.python

`.dockerignore`: https://github.com/rizl-ad/shvirtd-example-python/blob/main/.dockerignore

Содержимое каталока проекта на момент наполнения `.dockerignore`:

<img width="355" height="123" alt="w1_3" src="https://github.com/user-attachments/assets/62e7912a-5468-4f33-8e56-6ac322c351b5" />

Сборка и запуск контейнера

<img width="785" height="200" alt="w1_1" src="https://github.com/user-attachments/assets/5ab5ea0d-553d-484c-a9b3-07b79a4c5f16" />

<img width="909" height="234" alt="w1_2" src="https://github.com/user-attachments/assets/d5fc006b-6c8a-453d-a136-773bfa6997d1" />

Приложение запустилось, порт слушает, но понятно, что без БД не работает.

### п.3

БД запущена в контейнере, пароль от root MySQL и файл инициализации БД переданы при запуске контейнера:

`.env`: https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/virt/04-docker-in-practice/task-1.3/.env

`init.sql`: https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/virt/04-docker-in-practice/task-1.3/init.sql

<img width="837" height="357" alt="w1_z" src="https://github.com/user-attachments/assets/8f78772e-a502-4ffd-8808-c452baf8ea3f" />

По понятным причинам, при локальном запуске имеем результат:

<img width="429" height="99" alt="w1_z_2" src="https://github.com/user-attachments/assets/7ede4251-d99c-48c1-b81b-a2b6edf98816" />

## Задача 2


## Задача 3


## Задача 4


## Задача 5



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

### п.4

`main.ry` с переменной названия таблицы: https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/virt/04-docker-in-practice/task-1.4/main.py

<img width="818" height="599" alt="w1_z_3" src="https://github.com/user-attachments/assets/f528a52f-6648-4d12-86ff-c1c91b59cfcf" />

## Задача 2

<img width="492" height="700" alt="t2_1" src="https://github.com/user-attachments/assets/c8e15568-d8d0-452f-b82a-00337a4beb34" />

## Задача 3

Задачу не удалось решить в рамках существующих условий. Причиной требуемых изменений стал SSL на сервере MySQL.

После сборки и запуска проекта, приложению не удавалось подключиться к БД с ошибкой:  
`{"error":"Ошибка при работе с базой данных: 1146 (42S02): Table 'virtd.requests' doesn't exist"}`

При попытке подключиться из консоли web на db получил:  
`ERROR 2026 (HY000): TLS/SSL error: self-signed certificate in certificate chain`

Дальше я почти 3 дня (с "кровью", нервами и неприлично большими затратами времени) с помощью гугла пытался решить эту и прочие вытекающие проблемы различными способами (отключение SSL на сервере MySQL, подкидывание сертов и ключей, отключение SSL на клиенте) - безрезультатно.
 
В итоге проект я запустил, но со следующими отклонениями от задачи: 
1. `main.py` - в `get_db_connection()` для отключения SSL добавлена строка `ssl_disabled=True`
2. `.env` - переименованы переменные для имени БД, пользователя БД и его пароля. Сделано чтобы MySQL при инициализации не заводил сущности из этих переменных, иначе при инициализации не запускался необходимый sql-скрипт.
3. `init.sql` - создан в целях создания БД, и пользователя с необходимыми параметрами при начальной инициализации MySQL.
4. `my.cnf` - создан для конфигурирования mysqld - для подключения плагина mysql_native_password.

Все файлики в форке: https://github.com/rizl-ad/shvirtd-example-python/tree/main

И еще: приложение срабатывает без ошибки только после перезапуска контейнера web. С первого раза всегда ошибка.  
В консоли хоста: {"error":"Ошибка при работе с базой данных: 1146 (42S02): Table 'virtd.requests' doesn't exist"}  
В `docker logs`: Ошибка при подключении к БД или создании таблицы: 2003 (HY000): Can't connect to MySQL server on 'db:3306' (111)  
При этом если первый раз пробовать подключиться из консоли web MySQL-клиентом, ошибки нет.

Собственно, результат:  
<img width="487" height="423" alt="t3" src="https://github.com/user-attachments/assets/d217f085-f047-494b-ba81-d04cdcbf766e" />

Вопрос по проблеме задан на страничке ДЗ.  
Ну и дублирую: подскажите как решить вопрос с SSL у MySQL или что я делаю не так?

## Задача 4

bash-скрипт в форке: https://github.com/rizl-ad/shvirtd-example-python/blob/main/github_fork_clone.sh

<img width="642" height="573" alt="t4_1" src="https://github.com/user-attachments/assets/2894f5ee-53b0-4f75-9944-4594c460ddc1" />

## Задача 5

Скрипт: https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/virt/04-docker-in-practice/task-5/sqldump.sh

<img width="430" height="151" alt="t5_1" src="https://github.com/user-attachments/assets/d3d415ef-f6b5-4ec3-a94b-22dd9c34b801" />

## Задача 6

## Задача 7

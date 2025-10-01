# Решение ДЗ к занятию 3 «Использование Ansible»

В playbook описаны:

Обработчики:
- включение автозапуска и перезапуск сервиса clickhouse-server;
- включение автозапуска и перезапуск сервиса vector;
- включение автозапуска и перезапуск сервиса nginx;

Задания:
- загрузка установочных пакетов clickhouse, с обработкой ошибки загрузки и выполнением дополнительного задания загрузки;
- установка пакетов clickhouse, с вызовом обработчика перезагрузки сервиса clickhouse-server;
- принудительный запуск обработчика перезагрузки сервиса clickhouse-server;
- задержка выполнения playbook - добавлена т.к. на ВМ с минимальными ресурсами clickhouse-server не успевает запуститься до начала выполнения задачи создания БД;
- создание БД clickhouse;
- загрузка установочного пакета vector;
- установка пакета vector;
- создание конфигурационного файла vector из jinja2 шаблона, с вызовом обработчика перезагрузки сервиса vector;
- установка пакета nginx;
- создание конфигурационного файла nginx из jinja2 шаблона, с вызовом обработчика перезагрузки сервиса vector;
- установка пакета git;
- загрузка репозитория lighthouse;

playbook состоит из 3-х play, каждый play выполняет tasks для одной из трёх групп хостов.

В playbook присутствуют директивы: name, hosts, handlers, become, tasks, block, rescue.

В playbook теги не определены.

### п. 5
<img width="429" height="115" alt="t5" src="https://github.com/user-attachments/assets/6ce19293-fca6-4087-b2eb-8d95e95f69c2" />

ansible-lint выдает предупреждение по поводу присвоения имен блокам, хотя все блоки поименованы.

Похоже, на баг ansible-lint.

### п. 6
<img width="681" height="334" alt="t6" src="https://github.com/user-attachments/assets/635cb9b3-6c34-42dc-92da-b7dbdcd50793" />

Команда с параметром `--check` завершена неудачей по причине отсутствия файлов пакетов, т.к. при запуске команды с данным параметром ansible имитирует выполнение playbook не внося изменения, и, соответственно, не загружая пакеты.

### п. 7
Первый запуск команды с параметром `--diff`:   
<img width="679" height="1211" alt="t7" src="https://github.com/user-attachments/assets/289a8224-a87a-4550-9179-b19352a47618" />

Удостоверяемся в корректности выполнения playbook:   
на хосте clickhouse01:   
<img width="652" height="156" alt="t7_1" src="https://github.com/user-attachments/assets/eebd2acd-42e3-4720-8e54-a9fa05867c79" />

на хосте vector01:   
<img width="417" height="130" alt="t7_2" src="https://github.com/user-attachments/assets/2a53e601-aedc-4347-bffc-83d0db4bc263" />

на хосте lighthouse01:   
<img width="420" height="310" alt="t7_3" src="https://github.com/user-attachments/assets/ba1fc11c-911c-44b8-94f5-a3fea1103e0c" />

<img width="298" height="85" alt="t7_4" src="https://github.com/user-attachments/assets/e078547a-0634-41c0-a7da-28c824401e7e" />

### п. 8
Второй запуск команды с параметром `--diff` - playbook идемпотентен:   
<img width="681" height="582" alt="t8" src="https://github.com/user-attachments/assets/6464f507-e2d8-4c94-8054-c16542309c71" />

### п. 10
Ссылка на commit: https://github.com/rizl-ad/SHDEVOPS-22-HW/commit/f57ccaa0bc77709f5ce36ab9febd3a4d12fbc5a3


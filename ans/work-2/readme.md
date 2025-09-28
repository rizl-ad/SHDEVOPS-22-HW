# Решение ДЗ к занятию 2 «Работа с Playbook»

В playbook описаны:   
Обработчики:
- включение автозапуска и перезапуск сервиса clickhouse-server;
- включение автозапуска и перезапуск сервиса vector;

Задания:
- загрузка установочных пакетов clickhouse, с обработкой ошибки загрузки и выполнением дополнительного задания загрузки;
- установка пакетов clickhouse, с вызовом обработчика перезагрузки сервиса clickhouse-server;
- принудительный запуск обработчика перезагрузки сервиса clickhouse-server;
 - задержка выполнения playbook - добавлена т.к. на ВМ с минимальными ресурсами clickhouse-server не успевает запуститься до начала выполнения задачи создания БД;
- создание БД clickhouse;
- загрузка установочного пакета vector;
- установка пакета vector;
- создание конфигурационного файла vector из jinja2 шаблона, с вызовом обработчика перезагрузки сервиса vector;

В playbook теги не определены.

### п. 5
<img width="425" height="147" alt="t5_1" src="https://github.com/user-attachments/assets/4884ff97-2495-45ed-a52e-610cabef53a9" />

ansible-lint выдает два предупреждения, ни с одним из них не согласен:
1. все задачи поименованы
2. отступы соответствуют степени вложенности
Похоже, на баг ansible-lint, если не прав, прошу пояснить.

### п. 6
<img width="754" height="328" alt="t6" src="https://github.com/user-attachments/assets/212873ed-3f94-4240-aa13-19a8b9c3eaa5" />

Команда с параметром `--check` завершена неудачей по причине отсутствия файлов пакетов, т.к. при запуске команды с данным параметром ansible имитирует выполнение playbook не внося изменения, и, соответственно, не загружая пакеты.

### п. 7
Первый запуск команды с параметром `--diff`:   
<img width="752" height="873" alt="t7_1" src="https://github.com/user-attachments/assets/2bc9bec9-a929-4194-899d-a1f4f92bd6d3" />

Удостоверяемся в корректности выполнения playbook:   
<img width="661" height="268" alt="t7_2" src="https://github.com/user-attachments/assets/f7f5c490-79f6-4a33-ab09-e636c1a35429" />

### п. 8
Второй запуск команды с параметром `--diff` - playbook идемпотентен:   
<img width="752" height="362" alt="t8" src="https://github.com/user-attachments/assets/9c37a165-c275-46a1-8249-e898577a1ef1" />

### п. 10
Ссылка на commit: https://github.com/rizl-ad/SHDEVOPS-22-HW/commit/b420e71816c758c72f4b71179f255ec28d7fe979


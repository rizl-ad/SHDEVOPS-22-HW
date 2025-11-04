# Решение ДЗ к занятию 14 «Средство визуализации Grafana»

## Задание повышенной сложности

Конфигурации:
- docker-compose.yml
- prometheus.yml

Переменные окружения загружаемые из файла .env в контейнер grafana:
1. Авторизационные данные Grafana:
- GF_SECURITY_ADMIN_USER
- GF_SECURITY_ADMIN_PASSWORD
- GF_AUTH_ANONYMOUS_ENABLED
2. Конфигурирование отправки алертов через SMTP:
- GF_SMTP_ENABLED
- GF_SMTP_HOST
- GF_SMTP_USER
- GF_SMTP_PASSWORD
- GF_SMTP_FROM_ADDRESS
- GF_SMTP_SKIP_VERIFY

Cкриншоты событий из e-mail-канала нотификаций:


## Обязательные задания

### Задание 1

Скриншот веб-интерфейса grafana со списком подключенных Datasource:



### Задание 2

PromQL запросы:
- CPU util: `100 - (avg by (instance) (rate(node_cpu_seconds_total{job="host-01",mode="idle"}[1m])) * 100)`.
- CPU Load average: три запроса `node_load1`, `node_load5`, `node_load15`.
- RAM Free: `node_memory_MemFree_bytes`.
- FS free: `min(node_filesystem_avail_bytes) by (device)`.

Скриншот Dashboard:



### Задание 3

Скриншот Dashboard с подключенными алертами:



### Задание 4

Dashboard JSON-файл: 
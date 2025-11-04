# Решение ДЗ к занятию 14 «Средство визуализации Grafana»

## Задание повышенной сложности

Конфигурации:
- [docker-compose.yml](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/mon/work-2/advanced/docker-compose.yml)
- [prometheus.yml](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/mon/work-2/advanced/prometheus/prometheus.yml)

Переменные окружения загружаемые из файла .env в контейнер grafana:
1. Авторизационные данные Grafana:
- `GF_SECURITY_ADMIN_USER`
- `GF_SECURITY_ADMIN_PASSWORD`
- `GF_AUTH_ANONYMOUS_ENABLED`
2. Конфигурирование e-mail-канала нотификации:
- `GF_SMTP_ENABLED`
- `GF_SMTP_HOST`
- `GF_SMTP_USER`
- `GF_SMTP_PASSWORD`
- `GF_SMTP_FROM_ADDRESS`
- `GF_SMTP_SKIP_VERIFY`

Cкриншоты событий из e-mail-канала нотификации:

<img width="484" height="556" alt="tA_1" src="https://github.com/user-attachments/assets/49bc31f0-1a5a-45ab-8301-399a00ffb61d" />

<img width="491" height="607" alt="tA_2" src="https://github.com/user-attachments/assets/28735b81-b4b5-4e86-9128-6924aff65a62" />

<img width="493" height="610" alt="tA_3" src="https://github.com/user-attachments/assets/ac878885-96a7-4ab6-ae04-089c278eb94c" />

## Обязательные задания

### Задание 1

Скриншот веб-интерфейса grafana со списком подключенных Datasource:

<img width="927" height="584" alt="t1_1" src="https://github.com/user-attachments/assets/70543e31-1a6d-4e02-bef9-3cf4c49fa9f2" />

### Задание 2

PromQL запросы:
- CPU util - `100 - (avg by (instance) (rate(node_cpu_seconds_total{job="host-01",mode="idle"}[1m])) * 100)`.
- CPU Load average - три запроса: `node_load1`, `node_load5`, `node_load15`.
- RAM Free - `node_memory_MemFree_bytes`.
- FS free - `min(node_filesystem_avail_bytes) by (device)`.

Скриншот Dashboard:

<img width="926" height="584" alt="t2_1" src="https://github.com/user-attachments/assets/6b06fc8d-a5c8-4edd-bd78-f53482d3df32" />

### Задание 3

Скриншот Dashboard с подключенными алертами:

<img width="925" height="585" alt="t3_1" src="https://github.com/user-attachments/assets/59746d21-0c9e-459e-82b6-7206a5128e84" />

### Задание 4

[Dashboard JSON-файл](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/mon/work-2/t4/dashboard.json)

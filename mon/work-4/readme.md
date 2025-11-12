# Решение ДЗ к занятию 16 «Платформа мониторинга Sentry»

## Задание 1

Скриншот меню Projects.:

<img width="1280" height="735" alt="t1_1" src="https://github.com/user-attachments/assets/93c2e3f9-aa82-47cb-8199-57b7d24a15d9" />

## Задание 2

Скриншот Stack trace:

<img width="1280" height="732" alt="t2_1" src="https://github.com/user-attachments/assets/7497d591-1d4d-4c82-b3c0-536bf350c65e" />
<br><br>
Скриншот списка событий проекта после нажатия Resolved:

<img width="1280" height="735" alt="t2_2" src="https://github.com/user-attachments/assets/c8a04998-fdc3-42f0-b47c-d2f243a8cee0" />

## Задание 3

Скриншот тела сообщения из оповещения на почте:

<img width="1086" height="547" alt="t3_1" src="https://github.com/user-attachments/assets/2c54bed1-a6d4-4478-b4cc-4df899381c84" />

## Задание повышенной сложности

В качестве проекта Python адаптирован модуль Ansible, написанный при выполнении необязательной части задания 6 «Создание собственных модулей» (Система управления конфигурациями).

Скриншот меню issues вашего проекта:

<img width="1280" height="735" alt="tA_1" src="https://github.com/user-attachments/assets/a2f80d85-7d53-4c2c-bd01-cc889b242773" />
<br><br>
Код подключения sentry_sdk:

```
import sentry_sdk
import logging
from sentry_sdk.integrations.logging import LoggingIntegration
from sentry_sdk.scrubber import EventScrubber, DEFAULT_DENYLIST, DEFAULT_PII_DENYLIST

send_to_sentry = LoggingIntegration(
    level=logging.INFO,
    event_level=logging.INFO
)

denylist = DEFAULT_DENYLIST + ["folder_id", "user_name"]
pii_denylist = DEFAULT_PII_DENYLIST + ["sdk", "sa_key_f", "ssh_key_file", "ssh_key_value"]

sentry_sdk.init(
    dsn="https://...",
    send_default_pii=False,
    event_scrubber=EventScrubber(recursive=True, denylist=denylist, pii_denylist=pii_denylist),
    integrations=[send_to_sentry],
    release="yc_vm_create@1.0.0"
)

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
```

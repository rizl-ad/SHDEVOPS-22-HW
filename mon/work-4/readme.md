# Решение ДЗ к занятию 16 «Платформа мониторинга Sentry»

## Задание 1

Скриншот меню Projects.:



## Задание 2

Скриншот Stack trace:



Скриншот списка событий проекта после нажатия Resolved:



## Задание 3

Скриншот тела сообщения из оповещения на почте:



## Задание повышенной сложности

В качестве проекта Python адаптирован модуль Ansible, написанный при выполнении необязательной части задания 6 «Создание собственных модулей» (Система управления конфигурациями).

Скриншот меню issues вашего проекта:


Код подключения sentry_sdk:
`
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
`
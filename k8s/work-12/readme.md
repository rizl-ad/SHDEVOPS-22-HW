# Решение [ДЗ к занятию «Troubleshooting»](https://github.com/netology-code/kuber-homeworks/blob/main/3.5/3.5.md)

## Задание. При деплое приложение web-consumer не может подключиться к auth-db. Необходимо это исправить

Не смотря на указание в задании на проблему с подключением к сервису auth-db, у приложения существует еще одна проблема - поды web-consumer не запускаются выпадая в статус CrashLoopBackOff.   
<img width="324" height="70" alt="0" src="https://github.com/user-attachments/assets/60c0267d-d727-468f-b923-69b80c7a6c42" />

Эта проблема обусловлена следующими факторами:
- образ `radial/busyboxplus:curl` не является актуальным, т.к. его последняя публикация сделана более 10 лет назад; 
- образ `radial/busyboxplus:curl` содержит жестко заданную символическую ссылку для файла /etc/resolv.conf, которая указывает на несуществующий путь внутри образа;
- со времени последней публикации образа в архитектуре Kubernetes и способах управления файловой системой контейнеров произошли существенные изменения.

Когда Kubernetes пытается смонтировать актуальные настройки DNS в этот файл, операция завершается ошибкой, так как целевой путь ссылки недоступен.   
<img width="697" height="147" alt="2" src="https://github.com/user-attachments/assets/c6c863e4-0af2-41f9-836b-c690c2166d22" />

Для того чтобы убедиться в проблеме с символической ссылкой мы можем найти загруженный контейнер в K8s:   
<img width="694" height="36" alt="3" src="https://github.com/user-attachments/assets/e0bf7193-e7aa-4037-9b1d-aa7887e27390" />

Далее смонтировать контейнер во временный каталог:   
<img width="456" height="28" alt="4" src="https://github.com/user-attachments/assets/7d69bec5-fb4f-4a6d-bc94-2a465b7ea334" />

И убедиться что символическая ссылка указывает на несуществующий файл:   
<img width="382" height="36" alt="5" src="https://github.com/user-attachments/assets/eef9aca5-c5c1-4c98-9c59-3b7a0aa5f7a7" />

Данную проблему можно решить пересозданием файла /etc/resolv.conf внутри образа при помощи docker, сохранением исправленного образа в какое-либо registry и использованием в deployment исправленного образа.   
Но гораздо проще взять изначально рабочий актуальный образ, например curlimages/curl - как мы и поступили.   
<img width="302" height="121" alt="6" src="https://github.com/user-attachments/assets/94a66a96-13fb-4e5e-bd3f-8bb1c6e184ec" />

Вернемся к проблеме непосредственно задания - к проблеме доступа приложения web-consumer к auth-db.   
<img width="488" height="250" alt="7" src="https://github.com/user-attachments/assets/cce741bb-da13-430b-8ce5-9197aab9ec1f" />

Данная проблема связана с тем, что приложение и сервис находятся в разных namespace - приложение web-consumer в namespace `web`, а сервис и приложение auth-db в `data`.   
В K8s можно обращаться к сервису в другом namespace, используя или его полное доменное имя (FQDN), например, auth-db.data.svc.cluster.local, или сокращенное имя, например, auth-db.data. Это стандартный способ межпространственного взаимодействия в кластере, который обеспечивается CoreDNS K8s.   
<img width="328" height="249" alt="8" src="https://github.com/user-attachments/assets/df7fe32c-7ea0-413e-905d-139647f24257" />

Скорректированная [YAML-конфигурация](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-12/deployment.yaml)



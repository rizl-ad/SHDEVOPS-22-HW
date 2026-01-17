# Решение ДЗ к занятию «Как работает сеть в K8s»

## Задание 1. Создать сетевую политику или несколько политик для обеспечения доступа

[YAML-конфигурации](https://github.com/rizl-ad/SHDEVOPS-22-HW/tree/main/k8s/work-10/task-1)

Ноды, поды, сервисы:   
<img width="505" height="352" alt="1" src="https://github.com/user-attachments/assets/651f22f2-1b7b-4dab-be93-61e7850a610b" />

Отсутствие доступов после применения запрещающей политики:   
<img width="649" height="112" alt="2" src="https://github.com/user-attachments/assets/16447be0-c3d2-4363-a70c-e8bc8b3b2345" />


Наличие только доступов frontend -> backend -> cache после применения разрешающей политики:   
<img width="644" height="147" alt="3" src="https://github.com/user-attachments/assets/e94bc7fb-0e23-4be4-8bb3-9f0d26466387" />

Сетевые политики:   
<img width="290" height="53" alt="4" src="https://github.com/user-attachments/assets/6dc209a1-5ac8-41e3-ac7c-864c8ee09c41" />

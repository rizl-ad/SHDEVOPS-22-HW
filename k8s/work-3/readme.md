# Решение ДЗ к занятию «Запуск приложений в K8S»

## Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

[yaml-конфигурация Deployment](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-3/task1/deployment.yaml)

[yaml-конфигурация Service](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-3/task1/service.yaml)

[yaml-конфигурация Pod](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-3/task1/pod.yaml)

Pods до масштабирования:   
<img width="316" height="106" alt="t1_1" src="https://github.com/user-attachments/assets/b8e57658-7502-43c5-9d29-dca6d4ad6c53" />

Pods после масштабирования:   
<img width="355" height="146" alt="t1_2" src="https://github.com/user-attachments/assets/24185ef3-f6fb-4b80-94c5-04f5e158f2c4" />

Создание Service:   
<img width="577" height="293" alt="t1_3" src="https://github.com/user-attachments/assets/5d771144-b8a5-4938-911f-58b96b7490fd" />

Создание отдельного Pod:   
<img width="308" height="74" alt="t1_4" src="https://github.com/user-attachments/assets/900a32ae-f96f-4b83-9002-eb86e2362df9" />

Демонстрация доступа до приложений:   
В последних двух запросах `curl` к multitool видно работу балансировки - ответ приходит от разных контейнеров   
<img width="639" height="328" alt="t1_5" src="https://github.com/user-attachments/assets/c7f6d33d-bbf9-4f0c-83cb-2827788a3632" />

## Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

[yaml-конфигурация Deployment](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-3/task2/deployment.yaml)

[yaml-конфигурация Service](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-3/task2/service.yaml)

Состояние Pods до старта Service:   
<img width="338" height="131" alt="t2_1" src="https://github.com/user-attachments/assets/6f98f055-5835-4e29-b7a7-c7f18315c7a6" />

Состояние Pods после старта Service:   
<img width="338" height="95" alt="t2_2" src="https://github.com/user-attachments/assets/0a92e0d2-b32b-4888-be88-019249498ff7" />   
<img width="604" height="114" alt="t2_3" src="https://github.com/user-attachments/assets/710440cb-279b-4c19-b95c-e3f23dbf8978" />

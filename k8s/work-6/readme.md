# Решение ДЗ к занятию «Настройка приложений и управление доступом в Kubernetes»

## Задание 1. Работа с ConfigMaps

YAML-конфигурации:
- [configmap](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-6/task1/configmap.yaml)
- [deployment](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-6/task1/deployment.yaml)
- [service](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-6/task1/service.yaml)

Скриншот проверки доступности и вывода `curl`:   
<img width="635" height="428" alt="t1_1" src="https://github.com/user-attachments/assets/ca625f48-0cf9-4988-8621-713f6f4c5b12" />

## Задание 2. Настройка HTTPS с Secrets

YAML-конфигурации:
- [secret](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-6/task2/secret.yaml)
- [configmap](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-6/task2/configmap.yaml)
- [deployment](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-6/task2/deployment.yaml)
- [service](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-6/task2/service.yaml)
- [ingress](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-6/task2/ingress.yaml)

Скриншот вывода `curl`:   
<img width="277" height="140" alt="t2_1" src="https://github.com/user-attachments/assets/bcdfc64d-f48f-41af-840e-3384739f0a5b" />

## Задание 3. Настройка RBAC

YAML-конфигурации:
- [role](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-6/task3/role.yaml)
- [role-binding](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-6/task3/role-binding.yaml)

Скриншот команд генерации сертификатов:   
<img width="723" height="113" alt="t3_1" src="https://github.com/user-attachments/assets/e1cb9ead-54d9-4db4-ac74-969badcc8c6d" />

Скриншот проверки прав:   
<img width="645" height="412" alt="t3_2" src="https://github.com/user-attachments/assets/f9fed878-769c-4d25-9e43-0481f5f0e2be" />

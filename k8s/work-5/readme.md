# Решение ДЗ к занятию «Хранение в K8s»

## Задание 1. Volume: обмен данными между контейнерами в поде

[YAML-конфигурация](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-5/task1/deployment-shared-volume.yaml)

Скриншот описания пода с контейнерами:   
<img width="666" height="767" alt="t1_1" src="https://github.com/user-attachments/assets/6ad3ce3b-8c05-4106-9274-d0f0e9f46060" />

Скриншот команды чтения файла и его содержимого:   
<img width="549" height="123" alt="t1_2" src="https://github.com/user-attachments/assets/46433bf0-e93b-480e-825d-941c6531d7cc" />

## Задание 2. PV, PVC

[YAML-конфигурация](https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/k8s/work-5/task2/deployment-pv-pvc.yaml)

> [!NOTE]
> В конфигурации объявлен `storageClassName: work5-t2-scn`, но сам класс хранения не описан.

Скриншот создания Deployment, PV, PVC. Содержимое файла:   
<img width="622" height="240" alt="t2_1" src="https://github.com/user-attachments/assets/fa91c3c0-e36a-4957-8408-919eb46a8f4a" />

Скриншот удаления Deployment, PVC. Состояние файла:   
<img width="622" height="409" alt="t2_2" src="https://github.com/user-attachments/assets/9bf086b7-6d89-4822-839f-c8a67c412bf5" />

Скриншот удаления PV. Состояние файла:   
<img width="312" height="173" alt="t2_3" src="https://github.com/user-attachments/assets/831ade04-9cd4-4264-9406-dd05d2f8cebf" />

### Что произошло с PV и файлом? Почему?

Потому что: "error getting deleter volume plugin for volume "work5-t2-pv": no volume plugin matched":

Когда у PersistentVolume (PV) для политики Reclaim Policy установлено значение Delete, K8s при удалении PersistentVolumeClaim (PVC) также удаляет связанный с ним PV и его данные.   
Но политика Delete для локальных PV созданных вручную (через YAML-конфигурацию) имеет специфику, из-за которой автоматическое удаление файлов и самого объекта PV не происходит - при ручном создании PV и указании `local.path:` используется уже существующий ресурс для которого определяется статическое резервирование (Static Provisioning).   
Поскольку ресурс уже существует, в концепции K8s считается что администратор сам управляет жизненным циклом ресурса, поэтому внешний плагин для ресурса не предоставляется и K8s не может удалить PV и его данные.

## Задание 3. StorageClass

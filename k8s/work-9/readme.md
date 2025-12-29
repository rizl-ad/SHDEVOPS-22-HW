# Решение ДЗ к занятию «Установка Kubernetes»

## Задание 1. Установить кластер k8s с 1 master node

Задание выполнено на ВМ в Yandex Cloud.

Инициализация кластера выполнена через kubeadm.

Стек:
  - Ubuntu 24.04 LTS;
  - Kubernetes 1.35;
  - etcd 3.6.6 (в pod);
  - Containerd 1.7.28;
  - Flannel 0.27.4.

В процессе развертывания столкнулся с проблемами:
  - несоответствие драйверов cgroup по умолчанию у containerd и kubelet;
  - не загруженный модуль br_netfilter.

Скриншот результата:

<img width="595" height="240" alt="t1_1" src="https://github.com/user-attachments/assets/baa6f15c-5912-495f-a1a1-4bac8a1697ce" />

## Задание 2*. Установить HA кластер

Изначально планировал к результату первого задания присоединить дополнительные мастер-ноды, но каково было разочарование что в Yandex Cloud keepalive и прочие инструменты основанные на VRRP работают только через unicast и с некоторыми костылями. Стоп фактором стало требование нахождения всех нод в одной зоне и подсети.

В итоге пришлось все разворачивать заново уже на домашней технике, к тому же не хотелось использовать штатные облачные load balancer и сделать самостоятельно в связке HAProxy + Keepalived для балансировки нагрузки по мастер-нодам.

Инициализация кластера выполнена через kubeadm.

Стек:
  - Ubuntu 24.04 LTS (minimized);
  - Kubernetes 1.35;
  - etcd 3.6.6 (в pod);
  - Containerd 1.7.28;
  - Flannel 0.27.4;
  - Keepalive 2.2.8;
  - HAProxy 2.8.15.

Столкнулся с проблемами аналогичными первому заданию + настройка кластера на VIP.

Скриншоты результата:

<img width="487" height="510" alt="t2_1" src="https://github.com/user-attachments/assets/52dae060-220d-4f3c-b1d1-6cfa536f7983" />

<img width="1103" height="653" alt="t2_2" src="https://github.com/user-attachments/assets/0ecb0d7f-aa9a-4e21-a3d1-ebdd6a3c9ead" />

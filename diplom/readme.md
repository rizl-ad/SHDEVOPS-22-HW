# Дипломный проект

## Цели проекта:
1. Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.
2. Запустить и сконфигурировать Kubernetes кластер.
3. Установить и настроить систему мониторинга.
4. Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.
5. Настроить CI для автоматической сборки и тестирования.
6. Настроить CD для автоматического развёртывания приложения.

## Этапы выполнения:

### 1. Создание облачной инфраструктуры

Инфраструктура создается в Yandex Cloud при помощи Terraform.   
Создание инфраструктуры производится в два этапа:
1. Подготовка необходимых компонентов для развертывания инфраструктуры ([Terraform-проект yc_prep](https://github.com/rizl-ad/dip-yc/tree/debug/yc_prep)):
- сервисный аккаунт YC с авторизационным и статическим ключами;
- симметричный ключ шифрования;
- bucket для хранения Terraform State;
- dymanodb-таблица для записи Terraform State Lock;
2. Развертывание инфраструктуры ([Terraform-проект yc_infra](https://github.com/rizl-ad/dip-yc/tree/debug/yc_infra)):
- VPC с подсетями в разных зонах доступности;
- группы безопасности;
- таблица маршрутизации;
- бастион-сервер;
- NAT-instance;
- группа ВМ для master-нод кластера Kubernetes;
- группа ВМ для worker-нод кластера Kubernetes;
- сетевой балансировщик для доступа к приложениям кластера Kubernetes извне;
- L7-балансировщик для control-plane кластера Kubernetes;
- container registry.

Проекты Terraform размещены в репозитории [dip-yc](https://github.com/rizl-ad/dip-yc).

---

### 2. Создание Kubernetes кластера

Создание кластера Kubernetes реализовано рекомендуемым методом - self-managed кластер конфигурируемый самостоятельно подготовленными ролями Ansible.   
Основная конфигурация кластера включает роли:
- [k8s_nodes](https://github.com/rizl-ad/dip-k8s/tree/debug/roles/k8s_nodes)
- [k8s_master](https://github.com/rizl-ad/dip-k8s/tree/debug/roles/k8s_master)
- [calico](https://github.com/rizl-ad/dip-k8s/tree/debug/roles/calico)
- [helm](https://github.com/rizl-ad/dip-k8s/tree/debug/roles/helm)
- [k8s_worker](https://github.com/rizl-ad/dip-k8s/tree/debug/roles/k8s_worker)
- [ingress_nginx](https://github.com/rizl-ad/dip-k8s/tree/debug/roles/ingress_nginx)

Все конфигурации Ansible дипломного проекта размещены в репозитории [dip-k8s](https://github.com/rizl-ad/dip-k8s).

---

### 3. Создание тестового приложения

Для имитации приложения выбран рекомендуемый вариант:
- подготовлена простая конфигурация Nginx;
- подготовлены статические html-страницы;
- подготовлен Dockerfile;

Для развертывания приложения создан репозиторий [dip-app](https://github.com/rizl-ad/dip-app).   
Dockerfile, html и конфигурация Nginx размещены в каталоге [app](https://github.com/rizl-ad/dip-app/tree/debug/app) данного репзитория.

---

### 4. Подготовка cистемы мониторинга

Для развертывания системы мониторинга используется пакет [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus), который уже включает в себя Kubernetes оператор для Grafana, Prometheus, alertmanager и node_exporter.   
Установка пакета в Kubernetes кластер производится с помощью Ansible, [роль kube_prometheus](https://github.com/rizl-ad/dip-k8s/tree/debug/roles/kube_prometheus).

---

### 5. Подготовка cистемы развертывания приложения

Для автоматического развертывания приложения в Kubernetes кластер применен декларативный инструмент непрерывной доставки ArgoCD в сочетании с Helm-чартом, размещенном в каталоге [charts](https://github.com/rizl-ad/dip-app/tree/debug/charts) репозитория [dip-app](https://github.com/rizl-ad/dip-app).   
Установка производится с помощью Ansible, [роль argocd](https://github.com/rizl-ad/dip-k8s/tree/debug/roles/argocd).

---

### 5. Настройка CI/CD

В качестве CI/CD для развертывания инфраструктуры, автоматической сборки docker-образа и деплоя приложения выбрана платформа GitHub Actions.

Все репозитории дипломного проекта размещены на GitHub, всего их три:
- [dip-yc](https://github.com/rizl-ad/dip-yc)
- [dip-k8s](https://github.com/rizl-ad/dip-k8s)
- [dip-app](https://github.com/rizl-ad/dip-app)

Каждый репозиторий в каталоге `.github/workflows` имеет workflow.

### dip-yc
Имеет три workflow:
- [main.yml](https://github.com/rizl-ad/dip-yc/blob/debug/.github/workflows/main.yml) (Create YC infrastructure) - основной workflow репозитория, разворачивает инфраструктуру в YC. Запускается при commit изменений в проекты Terraform. В процессе выполнения предусмотрены bot-коммиты с планами изменений инфраструктуры, подготовленными Terraform, ожидающими ревью. По готовности инфраструктуры вызывает workflow репозитория dip-k8s.
- [destroy.yml](https://github.com/rizl-ad/dip-yc/blob/debug/.github/workflows/destroy.yml) (Destroy YC infrastructure) - workflow для уничтожения инфраструктуры, запускается только вручную. 
- [unlock.yml](https://github.com/rizl-ad/dip-yc/blob/debug/.github/workflows/unlock.yml) (Terraform state unlock) - workflow для снятия блокировки Terraform State, запускается только вручную.

### dip-k8s
[Workflow](https://github.com/rizl-ad/dip-k8s/blob/debug/.github/workflows/main.yml) (Deploy Kubernetes cluster) запускается при вызове из workflow репозитория dip-yc или при commit изменений в ролях Ansibl. Реализовано ревью вносимых изменений. Разделен на jobs:
- создание Kubernetes кластера;
- установка в кластер ArgoCD;
- установка cистемы мониторинга;
- вызов workflow репозитория dip-app

Задачи установки ArgoCD и мониторинга запускаются параллельно при готовности кластера Kubernetes.   
Workflow репозитория dip-app вызывается при готовности ArgoCD.

### dip-app

[Workflow](https://github.com/rizl-ad/dip-app/blob/debug/.github/workflows/main.yml) (Application CI/CD) репозитория запускается при вызове из workflow репозитория dip-k8s, при commit изменений в приложение или Helm-чарт, при слиянии в main. Реализовано ревью вносимых изменений.
Workflow имеет один job, который собирает docker-образ, тестирует его, размещает в registry и делает релиз c тегом `v*.*.*` при слиянии в main.

## Результат:

Инфраструктура доступна через бастион-сервер:

Внешний адрес сетевого балансировщика:

Приложение доступно в корне, без path-based маршрутизации, но протоколу http на 80 порту:

ArgoCD доступен по пути `/argocd` по протоколу http на 80 порту:

Grafana доступна по пути `/grafana` по протоколу http на 80 порту:

Docker-образ c тегом релиза в YC registry:




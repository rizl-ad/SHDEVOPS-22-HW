# Решение ДЗ к занятию 6 «Создание собственных модулей»

## Основная часть

Ссылка на архив: https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/ans/work-6/rizl_ad-my_collection-1.0.0.tar.gz

Ссылка на релиз: https://github.com/rizl-ad/ans_hw_collection/releases/tag/1.0.0

### п. 4
<img width="706" height="61" alt="p4" src="https://github.com/user-attachments/assets/cf5f971c-3574-4843-9907-afec40f78437" />

### п. 6
<img width="718" height="319" alt="p6" src="https://github.com/user-attachments/assets/588deff3-6d15-4da6-b621-190cf17aa69b" />

### п. 15, 16
<img width="713" height="335" alt="p15-16" src="https://github.com/user-attachments/assets/3d673e45-9a97-4eee-a024-cd2fa6dd2c4f" />

## Необязательная часть

Ссылка на collection: https://github.com/rizl-ad/ans_hw_collection.git

Ссылка на архив: https://github.com/rizl-ad/SHDEVOPS-22-HW/blob/main/ans/work-6/rizl_ad-my_collection-1.1.0.tar.gz

Ссылка на релиз: https://github.com/rizl-ad/ans_hw_collection/releases/tag/1.1.0

Коллекция содержит демонстрационный пример развертывания стека с использованием модуля создания виртуальных машин в Yandex Cloud.

Пример разделен на два playbook:
- instances.yml, вызывающий tasks-файл create_vm.yml - deploy виртуальных машин с inventory-файлом;
- stack.yml, вызывающий роли vector, lighthouse, clickhouse - deploy прикладной части.

Для удобства запуска сделан скрипт example.sh, последовательно запускающий playbooks.

Последовательность действий для запуска примера:
1. Установить зависимости:
  `ansible-galaxy install -r requirements.yml`
2. Задать валидные значения переменным параметров ВМ в файлах каталога vars в коллекции.
3. Сделать скрипт исполняемым и запустить его:
  `. example.sh`

> [!NOTE]
> Запуск примера/модуля yc_vm_create на Debian-подобных ОС осуществлять в виртуальном коружении Python.

### Скрины запуска демонстрационного скрипта

<img width="738" height="525" alt="t2_1" src="https://github.com/user-attachments/assets/37d31485-8c88-4748-9cdf-ab5a97fb9de4" />

<img width="737" height="535" alt="t2_2" src="https://github.com/user-attachments/assets/049ec6aa-a797-48ff-a2d4-24f5ee57afe9" />

<img width="738" height="518" alt="t2_3" src="https://github.com/user-attachments/assets/96f426e9-416c-436d-9362-7e8bcf3f48b0" />

<img width="736" height="509" alt="t2_4" src="https://github.com/user-attachments/assets/e3a9c0d9-6b20-4b67-a9a6-415725e7d706" />

<img width="734" height="211" alt="t2_5" src="https://github.com/user-attachments/assets/b88a211c-ccf1-4ea1-b026-78dd27878149" />

Playbooks успешно отработали.

<img width="738" height="524" alt="t2_6" src="https://github.com/user-attachments/assets/9a74407d-ce30-422f-8c95-598dfcb4df93" />

<img width="738" height="533" alt="t2_7" src="https://github.com/user-attachments/assets/30a2ce98-d1ef-4fb9-a04e-b7531a8b56c5" />

<img width="736" height="517" alt="t2_8" src="https://github.com/user-attachments/assets/d03fa5a4-60db-499e-85ee-8944e4b561a0" />

<img width="737" height="509" alt="t2_9" src="https://github.com/user-attachments/assets/1f6b4981-3905-4dca-bcda-80df6c585381" />

<img width="737" height="161" alt="t2_10" src="https://github.com/user-attachments/assets/e0194873-dba3-44f8-b9d0-5161541fe072" />

Playbooks идемпотенты.



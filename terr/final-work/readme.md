# Решение к итоговому проекту модуля «Облачная инфраструктура. Terraform»

## Инфраструктура описана в отдельных модулях.

Код проетка: https://github.com/rizl-ad/SHDEVOPS-22-HW/tree/main/terr/final-work/code

План развертывания:


## State-файл хранится удаленно, подключен statelocking.

<img width="690" height="220" alt="tf_state" src="https://github.com/user-attachments/assets/e454aeeb-b6e5-4e8b-8f1b-4115ccd07908" />

<img width="599" height="309" alt="state_lock" src="https://github.com/user-attachments/assets/c70417c5-2e34-450e-bcc8-42a556a71865" />


## Docker и Docker Compose в ВМ устанавливаются и запускаются через cloud-init.

<img width="754" height="463" alt="cloud_init_1" src="https://github.com/user-attachments/assets/84084c33-82f5-4bc3-852d-6d8336d1fb80" />

<img width="754" height="491" alt="cloud_init_2" src="https://github.com/user-attachments/assets/82a68977-ac17-4b2c-b71b-7feb6e156f92" />


## Docker-образ сохраняется в Yandex Container Registry.

<img width="726" height="199" alt="cr_cloud_init" src="https://github.com/user-attachments/assets/4f814855-2b89-4b9f-ab53-08163db6006f" />

<img width="452" height="204" alt="cr" src="https://github.com/user-attachments/assets/afb8690f-6308-484b-bb6e-2b33990b468b" />

<img width="772" height="208" alt="image" src="https://github.com/user-attachments/assets/78d7d8e1-88b0-4e6b-9d32-9357a3d51052" />


## Приложение работает с кластером MySQL, развернутым в Yandex Cloud.

<img width="488" height="640" alt="db_cl" src="https://github.com/user-attachments/assets/047c9446-06ac-464c-a82c-0bde9737aac9" />

<img width="1083" height="137" alt="db_cl_hosts" src="https://github.com/user-attachments/assets/3c39236a-153b-4437-bcee-1bcc3576e3f0" />

<img width="490" height="182" alt="db_cl_db" src="https://github.com/user-attachments/assets/983da847-5cdd-490f-ab95-0b18f44bb3bd" />

<img width="493" height="164" alt="db_cl_user" src="https://github.com/user-attachments/assets/8d6e9838-e2ae-489a-921d-19dea8112b2c" />


## Пароль пользователя БД генерируется в Yandex LockBox.

<img width="589" height="501" alt="lockbox" src="https://github.com/user-attachments/assets/54902074-774a-4b23-a552-712d071e7599" />


## Приложение доступно по публичному ip-адресу ВМ.

<img width="650" height="335" alt="sg_in" src="https://github.com/user-attachments/assets/5d6d027d-7c71-47eb-865b-271a007359cc" />

<img width="580" height="330" alt="sql" src="https://github.com/user-attachments/assets/c1d4fbbe-7a42-4a59-ae90-aada903329eb" />




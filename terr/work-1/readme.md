# Решение ДЗ к занятию «Введение в Terraform»

<img width="226" height="40" alt="t0_1" src="https://github.com/user-attachments/assets/f8337ed2-be90-4812-b006-9ffde476fd89" />

## Задача 1

### п. 1
<img width="648" height="317" alt="t1_p1" src="https://github.com/user-attachments/assets/93f5b4b1-afc1-47f0-a82e-1386436d1167" />

### п. 2
согласно файлу `.gitignore` авторизационные данные допустимо сохранить в файле `personal.auto.tfvars`

### п. 3
"result": "ipBtAJRPCQn85hTJ"

<img width="364" height="213" alt="t1_p3" src="https://github.com/user-attachments/assets/8c0dbf70-b6cf-4f0c-bf4d-6eec2e44dcf6" />

### п. 4, 5
строка 29 - имя ресурса должно начинаться с буквы/слова. 
строка 30 - обращение к необявленному ресурсу с типом "docker_image" и именем "nginx". 
строка 31 - обращение к необявленному ресурсу с типом "random_password" и именем "random_string_FAKE"; обращение к несуществующему атрибуту resulT

<img width="262" height="140" alt="t1_p4" src="https://github.com/user-attachments/assets/ad3fb7e4-b831-47a9-a944-f4e515bdcab4" />

<img width="547" height="37" alt="t1_p5" src="https://github.com/user-attachments/assets/330e5826-4e28-42bd-8e6a-e44d98b5ac6c" />

### п. 6

Применение ключа `-auto-approve` опасно отсутствием контроля применяемых изменений, нужно быть твердо уверенным в корректности кода.  
Тем не менее данный ключ полезен при построении полностью автоматизированных процессов CI/CD, где нужно исключить участие человека.

<img width="501" height="38" alt="t1_p6" src="https://github.com/user-attachments/assets/a23e5176-18a6-4322-b7c9-6db6c8b5dfe0" />

### п. 7

<img width="273" height="120" alt="t1_p7" src="https://github.com/user-attachments/assets/1d13d155-be4f-441f-97ef-f8ed98c8dd67" />

### п. 8

`keep_locally = true` - строка кода в ресурсе "docker_image.nginx" указывает на необходимость сохранения локальной копии образа.  
Цитата из документации: "`keep_locally` (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation."

## Задача 2

### п. 1, 2

Сделал через terraform, файлы проекта: https://github.com/rizl-ad/SHDEVOPS-22-HW/tree/main/terr/work-1/task-2/p1  
Аутентификационные данные для подстановки в переменные в неопубликованном файле `crd.auto.tfvars`.

### п. 3, 4

Файлы проекта: https://github.com/rizl-ad/SHDEVOPS-22-HW/tree/main/terr/work-1/task-2/p4  
Аутентификационные данные для подстановки в переменные в неопубликованном файле `crd.auto.tfvars`.

### п. 5

<img width="529" height="175" alt="t2_p5" src="https://github.com/user-attachments/assets/2734fe6d-a443-4112-b0eb-6bdec368b0a4" />

## Задача 3

Запуск проекта через OpenTofu отличался лишь названиием файла конфигурации (`.tofurc`) и зеркалом registry.

<img width="264" height="49" alt="t3_0" src="https://github.com/user-attachments/assets/21a561d5-9f36-416f-82b8-02637c447c89" />

Запуск первого проекта (создание ВМ):  
<img width="589" height="397" alt="t3_1" src="https://github.com/user-attachments/assets/69720347-140d-4421-8dd0-15153fadc4b8" />

Инициализация и запуск второго проекта (запуск конткйнера через remote ssh context):  
<img width="645" height="515" alt="t3_2" src="https://github.com/user-attachments/assets/b2505eb9-1ddb-42de-9189-3b02650fa290" />

<img width="584" height="371" alt="t3_3" src="https://github.com/user-attachments/assets/275c90e7-353b-4987-b056-1b81fe5728ae" />

Результат:  
<img width="532" height="176" alt="t3_4" src="https://github.com/user-attachments/assets/517eb6a7-2d3b-4338-a9f9-7bbd96f83062" />


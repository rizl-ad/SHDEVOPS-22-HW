# Рещение к ДЗ к занятию 4 «Оркестрация группой Docker контейнеров на примере Docker Compose»
## Задача 1
https://hub.docker.com/repository/docker/rizl/custom-nginx/general

## Задача 2
<img width="1328" height="405" alt="image" src="https://github.com/user-attachments/assets/55c0a7b8-9572-4731-9980-3fa9b7045e0e" />


## Задача 3
По п.3: для подключения к стандартному потоку ввода/вывода/ошибок контейнера используется команда ```docker attach```, при нажатии сочетания клавиш ```Ctrl+c``` контейнеру отправляется сигнал ```SIGINT```, останавливающий контейнер.

<img width="1104" height="819" alt="image" src="https://github.com/user-attachments/assets/e4e0af93-e65c-4b50-b6f0-f2b1c1a371aa" />
В образе nginx указаны устаревшие репозитории, поэтому обновляем ссылку на репозиторий:

<img width="1088" height="817" alt="image" src="https://github.com/user-attachments/assets/5dd63bf2-9206-4b8a-9106-0822fac39c78" />
<img width="1413" height="706" alt="image" src="https://github.com/user-attachments/assets/79bac7cb-5434-4b5a-9059-277fc10991a5" />

По п.10: в контейнере изменили порт прослушивания nginx c 80 на 81. Проброс порта при сборке контейнера назначили с 8080 хостовой ОС на 80 контейнера. Соответственно, 80-ый порт контейнера ничем не слушается и попытка подключения на 8080 хостовой ОС завершается неудачей.

<img width="762" height="338" alt="image" src="https://github.com/user-attachments/assets/edc4af0e-ace5-475b-b288-d5d97e16a51d" />

Доп задание (11): метод смены порта без создания нового контейнера такой себе - подходит если на хосте запущен только один контейнер.

<img width="1260" height="719" alt="image" src="https://github.com/user-attachments/assets/be87c0f3-9afd-4cbd-b624-3e0e4c29235f" />

Для удаления запущенного контейнера необходимо указать опцию -f/--forced

<img width="612" height="64" alt="image" src="https://github.com/user-attachments/assets/cf0d80f3-a20e-4081-9c16-50c3214f54a2" />


## Задача 4

## Задача 5


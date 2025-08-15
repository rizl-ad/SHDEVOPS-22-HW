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

<img width="947" height="595" alt="image" src="https://github.com/user-attachments/assets/20435cbe-f281-4a8e-86fa-9976f9041751" />

## Задача 5

<img width="1295" height="368" alt="image" src="https://github.com/user-attachments/assets/304926b6-87df-4786-8e73-3e0d7a53817d" />

Файл ```compose.yaml``` является предпочтительным, ```docker-compose.yml``` поддерживается для обратной совместимости с более ранними версиями.

<img width="1298" height="306" alt="image" src="https://github.com/user-attachments/assets/c2e7b98d-f08e-45e9-a89b-960e3159e37e" />

<img width="798" height="336" alt="w4 5_2" src="https://github.com/user-attachments/assets/44b2d645-0696-42e0-8f3a-71d08ee0256e" />

<img width="793" height="1001" alt="w4 5_5" src="https://github.com/user-attachments/assets/f567b85c-a2a6-461f-8040-ddea4719fff7" />

<img width="1388" height="192" alt="w4 5_7" src="https://github.com/user-attachments/assets/d66fb657-d4cc-4fa3-8861-02bd92680374" />

Сообщение «Found orphan containers…» указывает на то, что контейнер task5-portainer-1 запущен или существует в проекте с тем же именем, что и запускаемый проект, но не определенные текущем docker-compose.yml файле

<img width="1386" height="419" alt="w4 5_7" src="https://github.com/user-attachments/assets/c85ab2a0-8c27-47c9-8483-9169616be159" />

# Решение ДЗ к занятию «Основы Terraform. Yandex Cloud»

## Задача 1

### п. 4
Ошибки при выполнении проекта:
1. `platform_id = "standart-v2"` в ресурсе "yandex_compute_instance.platform" - строка содержит две ошибки: платформы "v4" не существует и правильное написание идентификатора платформы "standard" - "d" на конце.
2. `cores = 1` в ресурсе "yandex_compute_instance.platform" - допустимы значения кратные 2.
3. `core_fraction = 5` в ресурсе "yandex_compute_instance.platform" - значение 5% допустимо только на платформах "standard-v1" и "standard-v2".

## Задача 2

## Задача 3

## Задача 4

## Задача 5

## Задача 6

## Задача 7

## Задача 8

## Задача 9

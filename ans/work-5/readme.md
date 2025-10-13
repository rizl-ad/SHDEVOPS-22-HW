# Решение ДЗ к занятию 5 «Тестирование roles»

Для выполнения задания использовались следующие версии ПО:
- Ansible [core 2.16.3]
- Python 3.12.3
- Molecule 25.9.0
- Tox 4.13.0

## Molecule
### п. 1
При запуске molecule сценария ubuntu_xenial из роли clickhouse возникли ошибки, полагаю, из-за несовместимости версий python/ansible для которых написан сценарий с теми, что применены для выполнения задания.   
<img width="750" height="870" alt="t1_1" src="https://github.com/user-attachments/assets/4414db8e-db90-4c7a-aed3-53cb05bf4a84" />

### п. 2
Запуск команды `molecule init scenario --driver-name docker` завершился ошибкой, т.к. версия Molecule 25.9.0 не имеет опции `--driver-name`.   
<img width="593" height="268" alt="t1_2" src="https://github.com/user-attachments/assets/4d5a62c9-6a62-43f7-9531-849d4d2e771b" />

### п. 3-5
Для тестирования взяты контейнеры: centos:8, ubuntu:24.04, oraclelinux:9.
> [!NOTE]
> Поскольку роль изначально писалась под полноценные хосты, тестирование роли на контейнерах кажется не логичным.
> Можно было дописать роль для работы с контейнерами через docker/podman-нативные модули ansible, но тогда это было бы уже не тестирование ранее написанной роли, а тестирование новой части роли для контейнеров.
> Чтобы сохранить первоначальное назначение роли, было принято решение подготовить контейнеры для управления ими через ansible как полноценными хостами.
> Поэтому в сценариях тестирования включен playbook prepare.yml, устанавливающий Python в контейнеры.

Выполнение сценария тестирования:   
<img width="752" height="419" alt="t1_3" src="https://github.com/user-attachments/assets/d7874379-90a2-4778-86d0-eb496b53eb1f" />

<img width="753" height="107" alt="t1_4" src="https://github.com/user-attachments/assets/e5c42c69-9fc0-4443-8680-8e31c6d5a60b" />

<img width="752" height="449" alt="t1_5" src="https://github.com/user-attachments/assets/532b6bde-2fc0-4a1a-9472-de7741776c8a" />

<img width="752" height="63" alt="t1_6" src="https://github.com/user-attachments/assets/174a1935-e256-42b5-85b6-e5427d6984b9" />

<img width="752" height="49" alt="t1_7" src="https://github.com/user-attachments/assets/f15b05d9-1011-4a84-9797-74e9abb8ad28" />

<img width="750" height="49" alt="t1_8" src="https://github.com/user-attachments/assets/0a16499f-5ee4-47d6-854f-6fd2daf085ea" />

<img width="750" height="159" alt="t1_9" src="https://github.com/user-attachments/assets/749d9c0a-238c-4150-9795-e0af8b3f3e89" />

<img width="750" height="299" alt="t1_10" src="https://github.com/user-attachments/assets/88037b7e-b405-4f73-90b1-f5bea71caaf9" />

<img width="753" height="158" alt="t1_11" src="https://github.com/user-attachments/assets/28ac8a2e-1a9c-466e-95a8-9192fdddb1a4" />

<img width="752" height="405" alt="t1_12" src="https://github.com/user-attachments/assets/8429f559-7c97-457a-8b2b-0141280d5b94" />

<img width="750" height="126" alt="t1_13" src="https://github.com/user-attachments/assets/7ca54f77-1a79-42ce-bde2-6a3a7c36ed54" />

<img width="752" height="185" alt="t1_14" src="https://github.com/user-attachments/assets/3d34e79d-1261-4dbc-b6a1-1b35b40457ee" />

<img width="751" height="127" alt="t1_15" src="https://github.com/user-attachments/assets/b46cc0d2-bbd6-4d8f-8082-e71fa18b1cce" />

<img width="751" height="142" alt="t1_16" src="https://github.com/user-attachments/assets/ea8ffc14-058c-4ef4-8636-aad2bdba2e77" />

<img width="753" height="475" alt="t1_17" src="https://github.com/user-attachments/assets/f754436b-3048-41b4-93f8-8d7056e9ee74" />

<img width="751" height="236" alt="t1_18" src="https://github.com/user-attachments/assets/f5866cc9-d599-47a6-8e6f-cbf151f0fdaa" />

<img width="751" height="80" alt="t1_19" src="https://github.com/user-attachments/assets/9b9273fc-633d-4f71-907f-93a71981d39e" />

### п. 1
Ссылка на commit: https://github.com/rizl-ad/vector-role/commit/c3ed0fcea84385f506ceded76df435740423f5b3

## Tox
### п. 1



# 1. semestrální práce z předmětu KIV/DCE

## Zadání

Zadání je popsáno v [tomto](dce-task-1-2024.pdf) souboru.

## Docker image backendu

Backend je jednoduchý server implementovaný v Pythonu s využitím knihovny Flask. Na kořenové cestě vrací text "Hello, World!", dále pak poskytuje jedno API `GET /hello/{name}`, kde `name` je libovolný řetězec, jehož odpovědí je JSON objekt s atributem `message` a hodnotou `Hello, {name}! How are you?`. Server naslouchá příchozím požadavům na výchozím portu `5000`.

Docker image je pak založený na image `ubuntu:20.04` a je dodatečně instalován `python`, `pip`, `flask` a `curl`. Do adresáře `/service` je pak nakopírován soubor `simple-backend.py` obsahující jednoduchý Python server. Po spuštění příkazu `python3 /service/simple-backend.py` pak tento server poslouchá příchozím požadavům.

Sestavení a publikování tohoto image je realizováno pomocí GitHub Actions. Image je možné nalézt pod názvem `ghcr.io/honzaulrych/kiv-dce-sp1-ulrych-backend`, doporučený tag je `latest`.

## Požadavky

Pro tvorbu infrastruktury a vzdálenou instalaci programů je potřeba mít nainstalované nástroje Terraform a Ansible. Případně je možné využít přiložený _devcontainer_ používaný na cvičeních KIV/DCE.

## Vytvoření infrastruktury

Infrastruktura je tvořena pomocí nástroje Terraform a je definována v souboru `terraform.tf`. Vždy je tvořen jeden virtuální stroj pro load balancer a jeden až tři virtuální stroje pro backendy. Pro správné fungování je potřeba vyplnit následující proměnné:

- `opennebula_username`: uživatelské jméno v univerzitní instanci OpenNebula,
- `opennebula_password`: přihlašovací token,
- `cluster_size`: požadovaný počet backendů (1 až 3),
- `ssh_pubkey`: veřejný klíč pro připojení k virtuálním strojům pomocí `ssh`.

Po vyplnění těchto proměnných je možné příkazem `terraform apply` v adresáři `terraform` spustit tvorbu infrastruktury. Je-li infrastruktura úspěšně vytvořena, v adresáři `dynamic_inventories` vznikne soubor `cluster` obsahující seznam IP adres backend serverů a IP adresu load balanceru.

## Instalace programů

Programy jsou na virtuální stroje instalovány pomocí nástroje Ansible. Jsou definovány čtyři role:

- `python3`: nainstaluje Python.
- `docker`: nainstaluje Docker, vyžaduje roli `python3`.
- `backend`: spustí Docker kontejner jendoduchého backendu, vyžaduje roli `docker`.
- `nginx`: spustí Docker kontejner s load balancerem, vyžaduje roli `docker`. Konfigurace load balanceru je tvořena ze šablony popsané v souboru `ansible/roles/nginx/config/nginx.conf`.

Po úspěšném vytvoření infrastruktury je možné instalaci spustit v adresáři `ansible` příkazem `ansible-playbook -i ../dynamic_inventories/cluster sp1-cluster.yml`.
# Embedded Development Environment

Docker environment for:

- STM32
- AVR
- ESP32
- CH32V

## Build

```bash
docker compose build
```

## Pull
'''bash
docker compose pull
docker pull ghcr.io/dampfers/embedded-dev:latest
'''
В чем разница между docker pull и docker compose pull?
Обе команды скачивают один и тот же образ из интернета на ваш компьютер. Разница в том, что происходит после скачивания:
Если вы используете docker pull: Вы скачиваете образ в локальное хранилище Docker. Но чтобы запустить контейнер, вам придется вручную писать длинную команду docker run, в которой нужно прописать все параметры:
bash
1
Если вы используете docker compose: Вы скачиваете образ (docker compose pull), а затем запускаете его (docker compose up -d). Docker Compose сам подхватит все нужные настройки из вашего файла docker-compose.yml (права privileged, проброс USB-портов через /dev, папку workspace и т.д.).
Итог: Использовать docker pull ghcr.io/dampfers/embedded-dev:latest можно и это абсолютно нормально. Но для повседневной работы с вашим проектом связка docker compose pull ➔ docker compose up -d ➔ docker compose exec embedded bash будет намного удобнее, так как вам не нужно каждый раз помнить и вводить все флаги запуска вручную.

## Start

```bash
docker compose up -d
```

## Enter

```bash
docker compose exec embedded bash
```
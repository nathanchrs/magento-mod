# magento-mod

Software Development class coursework. Dockerized Magento 2.2, modified.

## How to run

Prerequisites:
- A Linux OS (recommended)
- [Docker CE](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)
- [Docker Compose](https://docs.docker.com/compose/install/)

1. Clone this repository.
2. `cd` to this repository's directory.
3. Make sure `init.sh` and `bin/magento` is executable. To check, use `ls -al` and `ls -al bin`. If they are not executable, use `chmod +x init.sh` and/or `chmod +x bin/magento` to fix it.
4. `docker-compose build`
5. `docker-compose up` to run containers. Wait a few minutes until all containers are ready (there are "entered running state" text on screen).
6. `docker-compose exec php /bin/sh` to get a shell on the running PHP container.
7. In the PHP container shell, run `./init.sh` to setup Magento from the CLI.

- To stop containers: `docker-compose stop`
- To start containers: `docker-compose up`
- To remove containers (WARNING! Resets all data on containers): `docker-compose down -v`

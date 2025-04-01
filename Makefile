include .env

HOST=$(shell hostname)
DATE=$(shell date +"%Y-%m-%d_%H:%M:%S")

ports:
	docker compose -f base.docker-compose.yml -f ports.docker-compose.yml up -d

traefik:
	docker compose -f base.docker-compose.yml -f traefik.docker-compose.yml up -d

up: traefik

restart:
	docker compose restart

stop:
	docker compose stop

down:
	docker compose down --volumes

cleanup:
	docker compose down --volumes --remove-orphans
	sudo rm -rf _volumes/mysql
	sudo rm -rf _volumes/mailpit

rebuild-traefik:
	docker compose -f base.docker-compose.yml -f traefik.docker-compose.yml build --no-cache

rebuild-ports:
	docker compose -f base.docker-compose.yml -f ports.docker-compose.yml build --no-cache

status:
	docker compose ps --all

php-shell:
	docker compose exec -it php_fpm bash

php-ext-list:
	docker compose exec php_fpm php -m

logs:
	docker compose logs --follow

dump-db:
	mkdir -p _dumps
	docker compose exec mysql /usr/bin/mysqldump -u root --password="${DB_ROOT_PASSWORD}" ${DB_NAME} > "_dumps/${DB_NAME}-${HOST}-${DATE}.sql"

test-config-traefik:
	docker compose -f base.docker-compose.yml -f traefik.docker-compose.yml config

test-config-ports:
	docker compose -f base.docker-compose.yml -f ports.docker-compose.yml config

laravel-init:
	rm -rf ./src/public
	docker compose exec php_fpm composer create-project laravel/laravel . "11.*"

site-off:
	docker compose exec php_fpm php artisan down

site-on:
	docker compose exec php_fpm php artisan up

clear-cache:
	docker compose exec php_fpm php artisan optimize:clear

deploy: site-off clear-cache
	docker compose exec php_fpm php artisan migrate
	docker compose exec php_fpm php artisan optimize
	$(MAKE) site-on

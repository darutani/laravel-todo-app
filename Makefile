include .env.example

# ----- コンテナ管理 -----
up:
	docker-compose up -d
up-a:
	docker-compose up
up-wait:
	docker-compose up -d --wait
up-build:
	docker-compose up -d --build
down:
	docker-compose down --remove-orphans
down-v:
	docker-compose down --volumes --remove-orphans
down-rmi:
	docker-compose down --remove-orphans --rmi local
down-rmi-v:
	docker-compose down --volumes --remove-orphans --rmi local

# ----- コンテナ操作 -----
.PHONY: app
app:
	docker-compose exec app /bin/bash

.PHONY: nginx
nginx:
	docker-compose exec nginx /bin/bash

.PHONY: mysql
mysql:
	docker-compose exec mysql /bin/bash

.PHONY: redis
redis:
	docker-compose exec redis /bin/bash

# ----- app操作 -----
composer-install:
	docker-compose run --rm app composer install
dump-autoload:
	docker-compose run --rm app composer dump-autoload
migrate:
	docker-compose exec app php artisan migrate
seed:
	docker-compose exec app php artisan db:seed
db-fresh:
	docker-compose exec app php artisan migrate:fresh
clear:
	docker-compose exec app php artisan optimize:clear
test:
	git branch --contains=HEAD
	docker-compose exec app php artisan test
npm-ci:
	docker-compose run --rm app npm ci
vite:
	docker-compose exec app npm run dev
vite-build:
	docker-compose exec app npm run build
openapi-generate:
	docker-compose exec app bash -c " \
			touch /docs/openapi/${PROJECT_NAME}-api.json \
			&& php artisan openapi:generate > /docs/openapi/${PROJECT_NAME}-api.json \
		"
route:
	docker-compose exec app php artisan route:list

# ----- 監視系 ----
log-api:
	tail -f ./src/storage/logs/laravel.log
log-mysql-err:
	docker-compose exec mysql tail -f /var/log/mysql/error.log
log-slow-query:
	docker-compose exec mysql tail -f /var/log/mysql/slow_query.log

# ----- ブラウザ操作系 -----
.PHONY: open
open:
	open -a "Google Chrome" https://${APP_DOMAIN}
open-%:
	open -a "Google Chrome" "https://${@:open-%=%}.${APP_DOMAIN}"
open-mailpit:
	open -a "Google Chrome" http://localhost:8025
open-minio:
	open -a "Google Chrome" http://localhost:9216
show-url:
	#########
	##
	## If the environment has been built successfully, you can check the app at the URLs below.
	##
	## WEB:   https://${APP_DOMAIN}
	## API:   https://${SUBDOMAIN_API}.${APP_DOMAIN}
	## ADMIN: https://${SUBDOMAIN_ADMIN}.${APP_DOMAIN}
	## MAIL:  http://localhost:8025
	## MINIO: http://localhost:9216
	##
	## To monitor changes and compile ASSETS, run the command `make vite`.
	##
	#########

# ----- その他スクリプトなど -----
allow-exec-scripts:
	chmod 755 ./.scripts/*.sh
append-hosts:
	sudo bash ./.scripts/append-hosts.sh
enable-https:
	bash ./.scripts/enable-https.sh
copy-env:
	cp .env.example .env
	cp ./src/.env.example ./src/.env
checkout:
	@make copy-env
	@make composer-install

# ----- 初回環境構築用 -----
init:
	@make copy-env
	@make allow-exec-scripts
	@make append-hosts
	@make enable-https
	@make composer-install
	@make npm-ci
	@make up-wait
	@make up
	@make migrate
	@make vite-build
	@make show-url


cache-clear:
	docker compose exec app php artisan cache:clear
	docker compose exec app php artisan config:clear
	docker compose exec app php artisan route:clear
	docker compose exec app php artisan view:clear

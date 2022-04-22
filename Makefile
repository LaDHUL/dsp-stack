.PHONY: up
up: ## performs a docker-compose up -d
	docker-compose up -d

.PHONY: db-start
db-start: ## performs a docker-compose up -d db
	docker-compose up -d db

.PHONY: db-purge
db-purge: down ## stops the db and performs a sudo rm -r db/data
	docker volume rm dsp-stack_db-home

.PHONY: db-init
db-init: db-start ## starts the db and creates an empty repository
	./scripts/wait-for-db.sh
	make -C scripts fuseki-init-knora-test-minimal

.PHONY: db-backup
db-backup: ## downloads the database and saves it in backup.trig
	@echo $@
	@mkdir -p backup
	@curl -X GET -H "Accept: application/trig" -u "admin:test" "http://0.0.0.0:3030/knora-test" > "backup/backup.trig"

.PHONY: db-restore
db-restore: ## restore the file backup.trig to fuseki
	@echo $@
	@curl -X POST -H "Content-Type: application/trig" --data-binary "@backup//backup.trig" -u "admin:test" "http://0.0.0.0:3030/knora-test"

.PHONY: down
down: ## performs a docker-compose down
	docker-compose down

.PHONY: pull
pull: ## performs a docker-compose pull
	docker-compose pull

.PHONY: ps
ps: ## list running services
	docker-compose ps

.PHONY: logs
logs: ## list running services
	docker-compose logs -tf

.PHONY: help
help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

.DEFAULT_GOAL := help

# Makefile para gerenciar migrations do Flask

SERVICE=web-dev
DB_SERVICE=mysql-dev
DB_USER=devuser
DB_PASS=devpass
DB_NAME=devdb

# Cria a pasta migrations (apenas na primeira vez)
init:
	docker compose exec $(SERVICE) flask db init

# Gera uma nova migration com mensagem
migrate:
	docker compose exec $(SERVICE) flask db migrate -m "$(msg)"

# Aplica migrations no banco
upgrade:
	docker compose exec $(SERVICE) flask db upgrade

# Reverte última migration
downgrade:
	docker compose exec $(SERVICE) flask db downgrade

# Atalho para abrir shell dentro do contêiner
shell:
	docker compose exec $(env) bash

# Atalho para compose --profile dev
devup:
	docker compose --profile dev up
devdown:
	docker compose --profile dev down

# Atalho para compose --profile prod
produp:
	docker compose --profile prod up
proddown:
	docker compose --profile prod down

# Abre cliente MySQL direto no contêiner do banco
dbshell:
	docker compose exec $(DB_SERVICE) mysql -u $(DB_USER) -p$(DB_PASS) $(DB_NAME)
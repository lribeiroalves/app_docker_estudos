# Makefile para gerenciar migrations do Flask

SERVICE=web
DB_SERVICE=mysql
DB_USER=ribeiro
DB_NAME=db

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
	docker compose exec $(SERVICE) bash

# Atalho para compose --profile dev
dev-up:
	docker compose --profile dev up
dev-down:
	docker compose --profile dev down

# Atalho para compose --profile prod
prod-up:
	docker compose --profile prod up
prod-down:
	docker compose --profile prod down

# Abre cliente MySQL direto no contêiner do banco
db-shell:
	docker compose exec $(DB_SERVICE) mysql -u $(DB_USER) -p$(DB_USER) $(DB_NAME)
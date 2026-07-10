# Makefile para gerenciar migrations do Flask

# Serviço do docker-compose (ajuste se usar web-prod)
SERVICE=web

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

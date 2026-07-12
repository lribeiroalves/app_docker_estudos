# 🚀 Projeto Flask com Docker, Nginx e MySQL

Este repositório contém uma aplicação Flask estruturada para rodar em ambientes **dev** e **prod**, utilizando **Docker Compose**, **Nginx** como proxy reverso e **MySQL** como banco de dados.  
O projeto segue padrões de mercado e boas práticas para desenvolvimento, testes e deploy.

---

## 📂 Estrutura do Projeto

```text
app_docker_estudos/
├─ app/                # Código principal da aplicação Flask
├─ config/             # Configurações (.toml)
├─ migrations/         # Migrations do Alembic
├─ nginx/              # Configurações do Nginx
├─ tests/              # Testes automatizados
├─ .env.dev            # Variáveis de ambiente para desenvolvimento
├─ .env.prod           # Variáveis de ambiente para produção
├─ docker-compose.yml  # Orquestração dos serviços
├─ Dockerfile          # Build da aplicação Flask
├─ requirements.txt    # Dependências Python
└─ wsgi.py             # Ponto de entrada da aplicação
```

---

## ⚙️ Pré-requisitos

- Docker >= 20.x  
- Docker Compose >= 2.x  
- Python 3.11 (apenas se rodar fora do container)  

---

## 🔑 Configuração de Ambiente

### Arquivos `.env`

O projeto utiliza variáveis de ambiente para separar **dev** e **prod**:

- `.env.dev` → usado no perfil de desenvolvimento  
- `.env.prod` → usado no perfil de produção  

Exemplo de variáveis:

```env
FLASK_ENV=development
FLASK_RUN_HOST=0.0.0.0
FLASK_RUN_PORT=5000

DB_CONTAINER=mysql-dev
DB_PORT=3306
MYSQL_ROOT_PASSWORD=ruser
MYSQL_DATABASE=db
MYSQL_USER=user
MYSQL_PASSWORD=pass
```

### Arquivo `secrets.toml`

Armazena segredos e chaves sensíveis (não versionado).  
Exemplo:

```toml
[default]
SECRET_KEY=uma_chave_segura
```

👉 **Importante**: nunca versionar `.env.*` nem `secrets.toml`. Adicione-os ao `.gitignore`.

---

## 🛠️ Como rodar o projeto

### Ambiente de Desenvolvimento

```bash
docker compose --profile dev up --build
```

- Flask acessível em `http://localhost:5001`  
- MySQL acessível apenas internamente (não exposto)

### Ambiente de Produção

```bash
docker compose --profile prod up --build -d
```

- Nginx acessível em `http://localhost` (porta 80)  
- HTTPS disponível em `https://localhost` (porta 443, certificado autoassinado)  
- MySQL acessível apenas internamente (não exposto)

---

## 📜 Migrations (Alembic)

O projeto utiliza **Alembic** para versionamento do banco de dados.

### Criar nova migration

```bash
docker compose run --rm web-dev alembic revision --autogenerate -m "mensagem"
```

### Aplicar migrations

```bash
docker compose run --rm web-dev alembic upgrade head
```

---

## 🔒 HTTPS Autoassinado (local)

Para simular produção com HTTPS:

1. Gerar certificados:

   ```bash
   mkdir -p ./nginx/certs
   openssl req -x509 -newkey rsa:4096 -keyout ./nginx/certs/selfsigned.key -out ./nginx/certs/selfsigned.crt -days 365 -nodes
   ```

2. O `docker-compose.yml` já monta essa pasta:

   ```yaml
   volumes:
     - ./nginx/certs:/etc/nginx/certs
   ```

3. Configuração Nginx (`flask.conf`):

   ```nginx
   ssl_certificate /etc/nginx/certs/selfsigned.crt;
   ssl_certificate_key /etc/nginx/certs/selfsigned.key;
   ```

👉 Navegadores vão alertar sobre certificado não confiável (normal em autoassinados).

---

## 🧪 Testes

Rodar testes automatizados:

```bash
docker compose run --rm web-dev pytest
```

---

## 📦 Boas práticas adotadas

- **Separação de ambientes** (`dev` e `prod`) com perfis Docker Compose.  
- **Proxy reverso com Nginx** para segurança e performance.  
- **Migrations com Alembic** para versionamento do banco.  
- **Arquivos `.env` e `secrets.toml` não versionados** (segurança).  
- **Certificados HTTPS autoassinados** para simulação local.  
- **Estrutura modular Flask** com blueprints e extensões.  
- **Testes automatizados** com Pytest.  

---

## 📄 Licença

Este projeto está licenciado sob a *MIT License*.

---

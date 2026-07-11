import click
from app.ext.database import db
from app.ext.database.models import Users


@click.command('seed-users')
def seed_users():
    usuarios = [
        {'nome': 'Lucas', 'idade': 31},
        {'nome': 'Selma', 'idade': 32},
        {'nome': 'Samantha', 'idade': 38},
        {'nome': 'Sandra', 'idade': 60}
    ]

    for u in usuarios:
        if not db.session.query(Users).filter_by(nome=u["nome"]).first():
            user = Users(nome=u['nome'], idade=u['idade'])
            db.session.add(user)
    
    db.session.commit()
    click.echo('Usuarios adicionados')
    
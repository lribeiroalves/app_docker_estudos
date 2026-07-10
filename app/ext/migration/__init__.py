from flask_migrate import Migrate
from app.ext.database import db


def init_app(app):
    migrate = Migrate(app, db)
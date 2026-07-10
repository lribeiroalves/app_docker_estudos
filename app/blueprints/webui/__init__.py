from flask import Blueprint
from datetime import datetime
from .views import index


bp = Blueprint('webui', __name__, template_folder='templates')


# URLs
bp.add_url_rule('/', view_func=index)


def init_app(app):
    app.register_blueprint(bp)
    app.jinja_env.globals['datetime'] = datetime
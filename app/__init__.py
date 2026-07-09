from flask import Flask, jsonify
import os


def create_app():
    template_dir = os.path.abspath('app/blueprints/_templates')
    static_dir = os.path.abspath('app/blueprints/_static')
    app = Flask(__name__, template_folder=template_dir, static_folder=static_dir)

    @app.errorhandler(400)
    def bad_request(error):
        response = jsonify({
            'error': 'Bad Request',
            'message': error.description
        })
        response.status_code = 400
        return response
    
    @app.route('/')
    def hello_world():
        return 'Hello, World!'
    
    return app

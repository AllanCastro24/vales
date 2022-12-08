# Sistema de vales LJeans

## Frontend

Sistema frontend desarrollado en angular consumiendo servicios python

## Backend

API Rest desarrollada en el microframework de Flask

Ejemplo de un backend sencillo en Flask
---
    from flask import Flask
    from flask import jsonify

    app = Flask(__name__)

    @app.route('/api/v1/users', methods=['GET'])
    def get_users():
        response = {'message': 'success'}
        return jsonify(response)

    @app.route('/api/v1/users/<id>', methods=['GET'])
    def get_user(id):
        response = {'message': 'success'}
        return jsonify(response)

    @app.route('/api/v1/users/', methods=['POST'])
    def create_user():
        response = {'message': 'success'}
        return jsonify(response)

    @app.route('/api/v1/users/<id>', methods=['PUT'])
    def update_user(id):
        response = {'message': 'success'}
        return jsonify(response)

    if __name__ == '__main__':
        app.debug = True
        app.run(host="0.0.0.0",port=5000)
---
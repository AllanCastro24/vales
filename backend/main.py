from flask import Flask
from flask import jsonify

app = Flask(__name__)
pruebas = True #Definir conexión de BD
    response = {'message': 'success'}
    return jsonify(response)

# Eliminar vale especifico
@app.route('/api/deleteVales/<id>', methods=['DELETE'])
def deleteVales(id):
    response = {'message': 'success'}
    return jsonify(response)

# Mostrar vales activos
@app.route('/api/getVales', methods=['GET'])
def getVales():
    response = {
        'id_vale': '',
        'tipo_vale': '',
        'id_ditribuidor': '',
        'nombre_distribuidor': '',
        'monto_vale': '',
        'fecha_limite': '',
        'cantidad': ''
    }
    return jsonify(response)

# Home
@app.route('/')
def home():
    response = {
        'Mensaje': 'Backend activo',
        'Modelo': 'Imprimiendo modelo...',
        'id_vale': '',
        'tipo_vale': '',
        'id_ditribuidor': '',
        'nombre_distribuidor': '',
        'monto_vale': '',
        'fecha_limite': '',
        'cantidad': ''
    }
    return jsonify(response)

def conectarBD():
    if pruebas:
        print('Endpoint: localhost')
    else:
        print('Endpoint: 193.84.177.213')

if __name__ == '__main__':
    conectarBD()
    app.debug = True
    app.run(host="0.0.0.0",port=5000)
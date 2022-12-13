from flask import Flask
from flask import jsonify
from flaskext.mysql import MySQL
from flask_cors import CORS

app = Flask(__name__)
pruebas = True #Definir conexión de BD
cors = CORS(app, resources={r"/api/*": {"origins": "*"}})
mysql = MySQL()

if pruebas:
    print('Endpoint: localhost')
    app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_PASSWORD'] = ''
    app.config['MYSQL_DATABASE_DB'] = 'ljeans'
    app.config['MYSQL_DATABASE_HOST'] = 'localhost'
else:
    print('Endpoint: 193.84.177.213')
    app.config['MYSQL_DATABASE_USER'] = 'r237674_vales'
    app.config['MYSQL_DATABASE_PASSWORD'] = 'C3kAhDNmJ9mp'
    app.config['MYSQL_DATABASE_DB'] = 'r237674_vales'
    app.config['MYSQL_DATABASE_HOST'] = '193.84.177.213'

mysql.init_app(app)

# Eliminar vale especifico
@app.route('/api/deleteVales/<id>', methods=['DELETE'])
def deleteVales(id):
    response = {'message': 'Eliminado con éxito'}
    return jsonify(response)

# Modificar vale especifico
@app.route('/api/editVales/<id>', methods=['POST'])
def editVales(id):
    response = {'message': 'Modificado con éxito'}
    return jsonify(response)

# Insertar vales
@app.route('/api/addVales/<id>', methods=['POST'])
def addVales(id):
    response = {'message': 'Agregado con éxito'}
    return jsonify(response)

# Mostrar vales activos
@app.route('/api/getVales', methods=['GET'])
def getVales():
    conn = mysql.connect()
    cursor = conn.cursor()

    cursor.execute("SELECT vales.*,distribuidores.nombre_distribuidor,distribuidores.apellidos_distribuidor FROM vales,distribuidores WHERE vales.id_distribuidor = distribuidores.id_distribuidor;")
    data = cursor.fetchall()
    if data != None:
        response = jsonify(data)
    else:
        response = ""
        
    return response

# Mostrar distribuidores activos
@app.route('/api/getDistribuidores', methods=['GET'])
def getDistribuidores():
    conn = mysql.connect()
    cursor =conn.cursor()

    cursor.execute("SELECT distribuidores.id_distribuidor,distribuidores.nombre_distribuidor,distribuidores.apellidos_distribuidor from distribuidores WHERE estado = 'A'")
    data = cursor.fetchall()
    if data != None:
        response = jsonify(data)
    else:
        response = ""
        
    return response

# Home
@app.route('/')
def home():
    response = {
        'Mensaje': 'Backend activo',
    }
    return jsonify(response)

if __name__ == '__main__':
    app.debug = True
    app.run(host="0.0.0.0",port=5000)
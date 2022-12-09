from flask import Flask
from flask import jsonify
from flaskext.mysql import MySQL
from flask_cors import CORS

app = Flask(__name__)
pruebas = False #Definir conexión de BD
cors = CORS(app, resources={r"/api/*": {"origins": "*"}})
mysql = MySQL()

if pruebas:
    print('Endpoint: localhost')
    app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_PASSWORD'] = ''
    app.config['MYSQL_DATABASE_DB'] = 'vales'
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
    response = {'message': 'success'}
    return jsonify(response)

# Mostrar vales activos
@app.route('/api/getVales', methods=['GET'])
def getVales():
    conn = mysql.connect()
    cursor =conn.cursor()

    cursor.execute("SELECT * from vales")
    data = cursor.fetchone()
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
        # 'Modelo': 'Imprimiendo modelo...',
        # 'id_vale': '',
        # 'tipo_vale': '',
        # 'id_ditribuidor': '',
        # 'nombre_distribuidor': '',
        # 'monto_vale': '',
        # 'fecha_limite': '',
        # 'cantidad': ''
    }
    return jsonify(response)

if __name__ == '__main__':
    app.debug = True
    app.run(host="0.0.0.0",port=5000)
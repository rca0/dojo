import json
from json.decoder import JSONDecodeError
from flask import (
    Flask,
    make_response,
    jsonify,
    request,
)

from gen import Gen


app = Flask(__name__)

@app.route('/api/v1/passgen', methods=['POST'])
def create_pass():
    gen = Gen()
    try:
        if request.method == 'POST':
            data = request.json
            password = gen.make_passwd(data)
            return json.dumps(password)
    except JSONDecodeError:
        raise JSONDecodeError

@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify({'error': 'Not found'}), 404)

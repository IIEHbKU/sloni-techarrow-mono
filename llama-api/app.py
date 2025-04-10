from flask import Flask
from flask_cors import CORS
from flask_restful import Api

from resources import *

app = Flask(__name__)
CORS(app, supports_credentials=True)

app.config.update({
    "SECRET_KEY": "dep-dodep",
    "JSON_AS_ASCII": False,
})


@app.route("/")
def route():
    return "OK"


api = Api(app)
api.add_resource(AnalysisResource, "/api/llama/analysis")


def main():
    app.run(host="0.0.0.0", port=8082)

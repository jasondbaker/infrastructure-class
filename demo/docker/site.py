from flask import Flask
app = Flask(__name__)


@app.route('/')
def root_page():
    return '<html><body><b>Working with containers is super fun!</b></body></html>'


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)

import json

from flask import Flask, Response
from random import randrange


# print a nice greeting.
def say_hello(username="World"):
    return '<p>Hello %s!</p>\n' % username


# some bits of text for the page.
header_text = '''
    <html>\n<head> <title>Flask Webapp</title> </head>\n<body>'''
instructions = '''
    <p>This is a RESTful web service! Append a username
    to the URL (for example: <code>/Marcus</code>) to say hello to
    someone specific. Or access <code>/data</code> to retrieve some information..</p>\n'''
home_link = '<p><a href="/">Back</a></p>\n'
footer_text = '</body>\n</html>'

app = Flask(__name__)

# add a rule for the index page.
@app.route('/')
def index():
    return header_text + say_hello() + instructions + footer_text

# add a rule when the page is accessed with a name appended to the site
# URL.
@app.route('/<username>', methods=['GET'])
def api_user(username):
    return header_text + say_hello(username) + home_link + footer_text


# add a rule for some random data
@app.route('/data')
def api_data():
    data = {
        'data': randrange(0, 101, 2)
    }
    js = json.dumps(data)

    resp = Response(js, status=200, mimetype='application/json')
    return resp


# add a rule for the healthcheck.
@app.route('/healthcheck')
def api_healthcheck():
    data = {
        'status': 'ok'
    }
    js = json.dumps(data)

    resp = Response(js, status=200, mimetype='application/json')
    return resp


# run the app.
if __name__ == "__main__":
    app.run()

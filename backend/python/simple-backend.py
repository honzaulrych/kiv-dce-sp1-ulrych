from flask import Flask
import socket

app = Flask(__name__)

@app.route("/hello/<name>")
def hello(name):
    message = f"Hello, {name}! How are you?"
    response = f'''
    {{\n\t"message": "{message}",\n\t"serverBy": "{socket.gethostname()}"\n}}\n
    '''
    code = 200
    return response, code, {'Content-Type': 'application/json'}

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

if __name__ == "__main__":
    app.run(host='0.0.0.0')
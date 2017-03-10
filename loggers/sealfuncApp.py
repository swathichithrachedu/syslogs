#!/usr/bin/python

from flask import Flask

from loggers.seal import syslog

app = Flask(__name__)

@app.route('/')
def hello():
    str = syslog('','','','')
    return str
if __name__ == '__main__':
    app.run('0.0.0.0',port=5000)

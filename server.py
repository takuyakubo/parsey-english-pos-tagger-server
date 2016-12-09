#!/usr/bin/python3

# sudo apt-get install python3-pip
# sudo pip3 install flask

import os
from flask import Flask, request, Response
from multiprocessing import Pool
from parser import parse_sentence
import json

app = Flask(__name__)
port = 80 if os.getuid() == 0 else 8000

pool = Pool(1, maxtasksperchild=50)

@app.route('/', methods = ['POST', 'GET'])
def index():
  data = request.args.get("q", "")
  if not data:
      data = request.data
  print("got something: '%s'" % data)
  if not data:
      return Response(status=500, response="error")

  result = pool.apply(parse_sentence, [data])

  return Response(
    response=json.dumps(result, indent=2),
    status=200,
    content_type="application/json")

if __name__ == '__main__':
    app.run(port=port, host="0.0.0.0")

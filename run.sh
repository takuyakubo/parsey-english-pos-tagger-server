#!/bin/bash
PORT=${$PARSEY_PORT:-5000}
docker run -p $PORT:5000 --rm -it parsey $1

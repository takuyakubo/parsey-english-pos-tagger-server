# Parsey McParseface server

A simple Python Flask app to provide Parsey McParseface over HTTP as an API.

This will not work with the standard tensorflow models package.

######To run:

Run on port 7777:

    $ docker run -it --rm -p 7777:80 andersrye/parsey-mcparseface-server
or detached:

    $ docker run -d -it --name -p 7777:80 parseyserver andersrye/parsey-mcparseface-server    

######To build:
    $ git clone https://github.com/andersrye/parsey-mcparseface-server.git
    $ cd parsey-mcparseface-server
    $ docker build -t parseyserver .
    $ docker run -it --rm -p 7777:80 parseyserver

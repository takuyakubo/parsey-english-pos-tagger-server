# Parsey McParseface server

A simple Python Flask app to provide Parsey McParseface over HTTP as an API.

Based on https://github.com/JoshData/parsey-mcparseface-server

### To run:

Run once on port 7777:

    $ docker run -it --rm -p 7777:80 andersrye/parsey-mcparseface-server
or detached:

    $ docker run -d -it --name -p 7777:80 parseyserver andersrye/parsey-mcparseface-server    

### To build:

    $ git clone https://github.com/andersrye/parsey-mcparseface-server.git
    $ cd parsey-mcparseface-server
    $ docker build -t parseyserver .
    $ docker run -it --rm -p 7777:80 parseyserver

### To use:

Post plain text, line separated sentences to it:

    $ curl -H "Content-Type:text/plain" -d "Bob brought the pizza to Alice." http://localhost:7777/

Returns a list (!) of JSON trees:

    [
      {
        "sentence": "Bob brought the pizza to Alice.",
        "tree": {
          "ROOT": [
            {
              "index": 2,
              "token": "brought",
              "label": "VERB",
              "pos": "VBD",
              "tree": {
                "nsubj": [
                  {
                    "index": 1,
                    "token": "Bob",
                    "label": "NOUN",
                    "pos": "NNP"
                  }
                ],
                "dobj": [
                  {
                    "index": 4,
                    "token": "pizza",
                    "label": "NOUN",
                    "pos": "NN",
                    "tree": {
                      "det": [
                        {
                          "index": 3,
                          "token": "the",
                          "label": "DET",
                          "pos": "DT"
                        }
                      ]
                    }
                  }
                ],
                "prep": [
                  {
                    "index": 5,
                    "token": "to",
                    "label": "ADP",
                    "pos": "IN",
                    "tree": {
                      "pobj": [
                        {
                          "index": 6,
                          "token": "Alice",
                          "label": "NOUN",
                          "pos": "NNP"
                        }
                      ]
                    }
                  }
                ],
                "punct": [
                  {
                    "index": 7,
                    "token": ".",
                    "label": ".",
                    "pos": "."
                  }
                ]
              }
            }
          ]
        }
      }
    ]

Or given some sentences.txt:

    Bob has a burger.
    Name this boat.
    Alice sends a message.
then

    $ curl -H "Content-Type:text/plain" --data-binary @sentences.txt http://localhost:7777/

gives

    [
      {
        "sentence": "Bob has a burger.",
        "tree": {
          "ROOT": [
            {
              "index": 2,
              "token": "has",
              "label": "VERB",
              "pos": "VBZ",
              "tree": {
                "nsubj": [
                  {
                    "index": 1,
                    "token": "Bob",
                    "label": "NOUN",
                    "pos": "NNP"
                  }
                ],
                "dobj": [
                  {
                    "index": 4,
                    "token": "burger",
                    "label": "NOUN",
                    "pos": "NN",
                    "tree": {
                      "det": [
                        {
                          "index": 3,
                          "token": "a",
                          "label": "DET",
                          "pos": "DT"
                        }
                      ]
                    }
                  }
                ],
                "punct": [
                  {
                    "index": 5,
                    "token": ".",
                    "label": ".",
                    "pos": "."
                  }
                ]
              }
            }
          ]
        }
      },
      <etc, etc...>
    ]

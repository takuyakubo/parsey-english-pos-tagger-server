# Parsey Universal Server

A simple Python Flask app to provide Parsey McParseface and its [Cousins](https://github.com/tensorflow/models/blob/master/syntaxnet/universal.md) over HTTP as an API.

### To run:

Run on port 7777:

    $ docker run -it --rm -p 7777:80 andersrye/parsey-universal-server

or detached:

    $ docker run -d -it -p 7777:80 --name parseyserver andersrye/parsey-universal-server    

The default model is English. To select models set the `PARSEY_MODELS` environment variable. Select one or more (comma separated) models of the ones available [here](https://github.com/tensorflow/models/blob/master/syntaxnet/universal.md) (NOTE: must be written exactly as it appears in that list)

    $ docker run -it --rm -p 7777:80 -e PARSEY_MODELS=Latin,English,Greek andersrye/parsey-universal-server

You can also set the batch size if necessary using the `PARSEY_BATCH_SIZE` environment variable (default 1)

### To build:

    $ git clone https://github.com/andersrye/parsey-universal-server.git
    $ cd parsey-universal-server
    $ docker build -t parseyserver .
    $ docker run -it --rm -p 7777:80 parseyserver

### Demo:

Navigate to http://localhost:7777/demo to view a simple demo.

### To use:

Post plain text, line separated sentences to it:

    $ curl -H "Content-Type:text/plain" --data-binary "Alea iacta est" http://localhost:7777/

Returns a list of lists of sentences and words, in what is essentially the [CoNLL-U](http://universaldependencies.org/format.html) format, just in JSON

    [
      [
        {
          "id": 1,
          "form": "Alea",
          "upostag": "NOUN",
          "xpostag": "n-s---fn-",
          "feats": {
            "Case": "Nom",
            "Gender": "Fem",
            "fPOS": "NOUN++n-s---fn-",
            "Number": "Sing"
          },
          "head": 2,
          "deprel": "nsubjpass"
        },
        {
          "id": 2,
          "form": "iacta",
          "upostag": "VERB",
          "xpostag": "v-srppfn-",
          "feats": {
            "Case": "Nom",
            "VerbForm": "Part",
            "Gender": "Fem",
            "fPOS": "VERB++v-srppfn-",
            "Number": "Sing",
            "Tense": "Past",
            "Aspect": "Perf",
            "Voice": "Pass"
          },
          "head": 0,
          "deprel": "ROOT"
        },
        {
          "id": 3,
          "form": "est",
          "upostag": "VERB",
          "xpostag": "v3spia---",
          "feats": {
            "VerbForm": "Fin",
            "fPOS": "VERB++v3spia---",
            "Number": "Sing",
            "Person": "3",
            "Tense": "Pres",
            "Voice": "Act",
            "Mood": "Ind"
          },
          "head": 2,
          "deprel": "auxpass"
        }
      ]
    ]

The default model is the first one in the `PARSEY_MODELS` list (in this case Latin). To use another, use the `language` query param: (must also match the model name exactly)

    $ curl -H "Content-Type:text/plain" --data-binary "The die is cast" http://localhost:7777/?language=English

Returns:

    [
      [
        {
          "id": 1,
          "form": "The",
          "upostag": "DET",
          "xpostag": "DT",
          "feats": {
            "Definite": "Def",
            "fPOS": "DET++DT",
            "PronType": "Art"
          },
          "head": 2,
          "deprel": "det"
        },
        {
          "id": 2,
          "form": "die",
          "upostag": "NOUN",
          "xpostag": "NN",
          "feats": {
            "fPOS": "NOUN++NN",
            "Number": "Sing"
          },
          "head": 4,
          "deprel": "nsubj"
        },
        {
          "id": 3,
          "form": "is",
          "upostag": "VERB",
          "xpostag": "VBZ",
          "feats": {
            "Mood": "Ind",
            "fPOS": "VERB++VBZ",
            "Number": "Sing",
            "Person": "3",
            "Tense": "Pres",
            "VerbForm": "Fin"
          },
          "head": 4,
          "deprel": "cop"
        },
        {
          "id": 4,
          "form": "cast",
          "upostag": "ADJ",
          "xpostag": "JJ",
          "feats": {
            "fPOS": "ADJ++JJ",
            "Degree": "Pos"
          },
          "head": 0,
          "deprel": "ROOT"
        }
      ]
    ]

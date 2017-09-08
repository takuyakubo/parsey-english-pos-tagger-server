FROM tensorflow/syntaxnet

ENV PARSEY_MODELS Spanish-AnCora

RUN pip install Flask

RUN cd /opt/tensorflow/syntaxnet/syntaxnet/models/parsey_universal && \
		curl http://download.tensorflow.org/models/parsey_universal/$PARSEY_MODELS.zip -o $PARSEY_MODELS.zip && \
		unzip $PARSEY_MODELS.zip && \
		rm $PARSEY_MODELS.zip
ADD server.py /opt/tensorflow/syntaxnet
ADD parser.py /opt/tensorflow/syntaxnet

WORKDIR /opt/tensorflow/syntaxnet


CMD /opt/tensorflow/syntaxnet/server.py
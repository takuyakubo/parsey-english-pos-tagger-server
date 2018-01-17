FROM tensorflow/syntaxnet

RUN pip install Flask

WORKDIR /opt/tensorflow/syntaxnet/syntaxnet/models/parsey_universal

COPY download_models.sh .
RUN ./download_models.sh
#RUN curl http://download.tensorflow.org/models/parsey_universal/Norwegian.zip -o Norwegian.zip && unzip Norwegian.zip && rm Norwegian.zip
#RUN curl http://download.tensorflow.org/models/parsey_universal/English.zip -o English.zip && unzip English.zip && rm English.zip

ADD server.py /opt/tensorflow/syntaxnet
ADD parser.py /opt/tensorflow/syntaxnet

WORKDIR /opt/tensorflow/syntaxnet


CMD python /opt/tensorflow/syntaxnet/server.py
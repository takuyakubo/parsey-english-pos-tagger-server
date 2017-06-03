FROM andersrye/syntaxnet-forever

RUN pip install flask

WORKDIR /opt/tensorflow/models/syntaxnet/syntaxnet/models/parsey_universal

COPY download_models.sh .
RUN ./download_models.sh
#RUN curl http://download.tensorflow.org/models/parsey_universal/Norwegian.zip -o Norwegian.zip && unzip Norwegian.zip && rm Norwegian.zip
#RUN curl http://download.tensorflow.org/models/parsey_universal/English.zip -o English.zip && unzip English.zip && rm English.zip

#RUN git clone https://github.com/JoshData/parsey-mcparseface-server.git /opt/parsefaceserver
ADD . /opt/parsefaceserver/

WORKDIR /opt/tensorflow

RUN apt-get update && apt-get install -y python3 && apt-get install -y python3-pip && pip3 install flask gunicorn

ENV PARSEY_MODELS Spanish

CMD gunicorn -b 0.0.0.0:8000 -w 4 -t 300 --pythonpath /opt/ parsefaceserver.server:app
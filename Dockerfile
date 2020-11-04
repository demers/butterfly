FROM ubuntu:16.04

# La variable JEU doit être définie
# La variable PORT doit être définie

RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    build-essential \
    libffi-dev \
    libssl-dev \
    python-dev \
    python-setuptools \
    ca-certificates \
 && easy_install pip \
 && pip install --upgrade setuptools \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

RUN apt-get update \
 && apt install -y bastet \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

WORKDIR /opt
ADD . /opt/app
WORKDIR /opt/app

RUN python setup.py build \
 && python setup.py install

ADD docker/run.sh /opt/run.sh
ADD docker/run_game.sh /opt/run_game.sh

EXPOSE 57575
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082
EXPOSE 8083
EXPOSE 8084
EXPOSE 8085
EXPOSE 8086
EXPOSE 8087
EXPOSE 8088

#CMD ["butterfly.server.py", "--unsecure", "--host=0.0.0.0", "--port=$PORT", "--shell=/opt/run_game.sh $JEU"]
CMD ["butterfly.server.py", "--unsecure", "--host=0.0.0.0"]
ENTRYPOINT ["docker/run.sh"]

#FROM ubuntu:16.04
FROM ubuntu:18.04

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
 #&& easy_install pip \
 && apt install -y python-pip \
 && pip install --upgrade pip \
 && pip install --upgrade setuptools \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

RUN apt-get update \
 && apt install -y bastet \
 && apt install -y ninvaders \
 && apt install -y pacman4console \
 && apt install -y nsnake \
 && apt install -y greed \
 && apt install -y bsdgames \
 && apt install -y moon-buggy \
 && apt install -y wget gcc \
 && wget https://raw.githubusercontent.com/mevdschee/2048.c/master/2048.c \
 && gcc -o 2048 2048.c \
 && mv ./2048 /usr/games/ \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

WORKDIR /opt
ADD . /opt/app
WORKDIR /opt/app

RUN python setup.py build \
 && python setup.py install

ADD docker/run.sh /opt/run.sh
ADD docker/run_game.sh /opt/run_game.sh

# Fichier par défaut de démarrage de la console
ADD docker/atstart.sh /tmp/atstart.sh

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

CMD /opt/run_game.sh $JEU; butterfly.server.py --unsecure --host=0.0.0.0 --port=$PORT --shell=/tmp/atstart.sh

# Exemple d'exécution: docker run --env PASSWORD=123 --env JEU=bastet --env PORT=57575 -d -p 57575:57575 butterfly

ENTRYPOINT ["docker/run.sh"]

#!/bin/bash
if [ $# -eq 0 ]
then
    echo "Pas de nom de jeu fourni..."
    exit 1
else
    #/usr/games/$1
    echo "#!/bin/bash" > /opt/atstart.sh
    echo "/usr/games/$1" >> /opt/atstart.sh
    chmod a+x /opt/atstart.sh
fi
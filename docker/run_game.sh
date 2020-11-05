#!/bin/bash
if [ $# -eq 0 ]
then
    echo "Pas de nom de jeu fourni..."
    exit 1
else
    #/usr/games/$1
    echo "#!/bin/bash" > /tmp/atstart.sh
    echo "/usr/games/$1" >> /tmp/atstart.sh
    chmod a+x /tmp/atstart.sh
fi
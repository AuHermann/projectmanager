#! /bin/bash

CONFIG_PATH=~/.config/projectmanager/
PROJECTS_FILE=${CONFIG_PATH}projects.txt

if [ $1 == open ]; then
    projectname=$(awk '{ print $1 }' $PROJECTS_FILE | fzf )
    projectdir=$(grep "\<$projectname\>" $PROJECTS_FILE | awk '{ print $2 }')
    tmux new-window -n $projectname -c $projectdir nvim .

elif [ $1 == create ]; then
    CREATE_SCRIPT=${CONFIG_PATH}createproject.sh
    tmux new-window $CREATE_SCRIPT

elif [ $1 == edit ]; then
    tmux new-window nvim $PROJECTS_FILE
else
    echo "Help:"
fi

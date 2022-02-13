#! /bin/bash

read -e -p "Enter Project name: " projectname
read -e -p "Enter new project path: " filepath

if [ ! -d $filepath ]; then
    mkdir -p $filepath
fi

full_path=$(realpath $filepath)
echo "$projectname $full_path" >> ~/.config/projectmanager/projects.txt
tmux rename-window $projectname
cd $full_path && nvim .


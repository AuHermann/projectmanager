#! /bin/bash

read -e -p "Enter Project name: " projectname
read -e -p "Enter new project path: " filepath
project_type=$(awk '{ print $0 }' $HOME/.config/projectmanager/types.txt | fzf )
read -e -p "Github repo? [y/n]" ghbool

if [ ! -d $filepath ]; then
    mkdir -p $filepath
fi

full_path=$(realpath $filepath)
echo "$projectname $full_path $project_type" >> ~/.config/projectmanager/projects.txt
tmux rename-window $projectname
cd $full_path 
command 

command () {
    case $project_type in
        jupyter)
            if [[ $ghbool == "y" ]]; then
                gh repo create --template auhermann/jupytertemplate $projectname
            fi
            jupyter notebook
            ;;
        c++)
            if [[ $ghbool == "y" ]]; then
                gh repo create --template auhermann/cpptemplate $projectname
            fi
            nvim .
            ;;
        report)
            if [[ $ghbool == "y" ]]; then
                gh repo create --template auhermann/markdown-report-preamble $projectname
            fi
            nvim .
            ;;
        *) 
            nvim .
            ;;
    esac
}

#!/bin/bash
# Autor: Allythy Rennan
# GitHub: https://github.com/allythy
# Blog: https://allythy.github.io/


if [[ $(dpkg --get-selections | grep imagemagick) ]]; then
    echo""
else
    read -p "O ImageMagick não está instalado. Deseja instalar[Y/N]?  " yes
    if [[ $yes = 'y' ]]; then
        sudo apt-get install imagemagick
    else
        exit
    fi
fi

read -p "Type of image extension: " type_photo
read -p "Name of new images: " name_photo
read -p "Percentage to resize between 1-100: " resize
echo

count=0
for photo in *.$type_photo;
do
    convert $photo -resize $resize% $name_photo-$count.$type_photo
    ((count=$count+1))
    echo "Resizing $photo"
done


if [[ -d compact ]]; then
    read -p "This directory already exists. Do you want to turn off [Y/N]?" delete
    if [[ $delete = "y" ]]; then
        rm -r compact
        mkdir compact
        mv $name_photo* compact
    else
        exit
    fi
else
    mkdir compact
    mv $name_photo* compact
fi

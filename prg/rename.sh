#!/bin/bash


IFS=$'\n' #change le separateur pour les fichiers ayant des espaces

for f in $(ls) ; do  # parcours tout les fichiers dans '.' 1 par 1
     name=$f

#enleve le 1er caractere si c'est un '#'
        if [[ ${name:0:1} == \# ]]; then
          mv $name ${name:1}
        fi

     
      

done

IFS=$' \t\n'

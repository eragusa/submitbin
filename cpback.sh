#!/bin/bash

for fold in `ls -d *1orb`
        do 

	echo "Copying from $fold to ~/simulazioni/NonResoEccBin/$fold"
	cp $fold/* ~/simulazioni/NonResoEccBin/$fold
        
        done

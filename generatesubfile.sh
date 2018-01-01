#!/bin/bash

NAME=$1

sed 's/PREFIX/'$NAME'/' ~/bin/submission_file_template > submission_file


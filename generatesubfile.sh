#!/bin/bash

NAME=$1

sed 's/PREFIX/'$NAME'/' ~/submitbin/submission_file_template > submission_file


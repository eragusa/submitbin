#!/bin/bash

PROCID=path_subst

$PROCID/daemonnohup.sh
less $PROCID/activenohupID.txt 

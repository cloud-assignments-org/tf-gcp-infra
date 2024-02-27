#!/bin/bash

RESOURCE=$1

if [ -z "$1" ]
then
    echo "Kindly provide a resource identification" && exit
else
    terraform destroy -auto-approve -target="${RESOURCE}"
    terraform apply -auto-approve -target="${RESOURCE}"
fi

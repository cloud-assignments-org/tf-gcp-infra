#!/bin/bash

PROJECT_ID=$1

gcloud auth login
gcloud auth application-default login
gcloud config set project "${PROJECT_ID}"

#!/bin/sh

minikube delete
minikube start --addons=ingress --ports=80:80 --memory=no-limit --cpus=no-limit

helm secrets install -f values.yaml -f secrets.values.yaml jira-clone-01 . --set runSeed=true --set runMigrations=true
helm install datadog-agent datadog/datadog -f values.yaml
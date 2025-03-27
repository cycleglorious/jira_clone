#!/bin/sh

minikube delete
sleep 5
minikube start --addons=ingress --ports=80:80 --memory=no-limit --cpus=no-limit

sleep 20
helm secrets install -f jira-clone/values.yaml -f jira-clone/secrets.values.yaml jira-clone-01 jira-clone --set runSeed=true --set runMigrations=true
helm install datadog-agent datadog/datadog -f jira-clone/values.yaml
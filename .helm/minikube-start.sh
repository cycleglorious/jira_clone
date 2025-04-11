#!/bin/sh

# minikube start --addons=ingress --ports=80:80 --memory=no-limit --cpus=no-limit
# sleep 30

helm secrets upgrade --install -f jira-clone/values.yaml -f jira-clone/secrets.values.yaml jira-clone-01 jira-clone
helm secrets upgrade --install datadog-agent datadog/datadog -f jira-clone/values.yaml -f jira-clone/secrets.values.yaml

#!/bin/sh

minikube delete
minikube start --addons=ingress --ports=80:80

# assessment-js
Tech assessment.
* 2 App Servers
* 1 Web Server
* Go Application

## Pre-Requisites
Assuming that you are on a \*nix-like system (Linux, Mac OS X) you will require
the following:
* GNU make
* Vagrant - http://www.vagrantup.com
* Docker (optional) - http://www.docker.com
* Docker Compose (optional) - https://www.docker.com/products/docker-compose

## TL;DR
Install Vagrant and run:
```
make vagrant
```

## Run the project
There are 2 ways to run the project, by running `make` you can see:
```
Targets available:
   docker:          Run app in Docker containers (for development use)
   docker-destroy:  Destroy Docker environment
   vagrant:         Create the app in Vagrant
   vagrant-destroy: Destroy Vagrant environment
```

### Targets
#### docker
On receiving the assessment, I wanted a really quick and easy way to PoC the Go
application running in 2 containers and load balanced by a reverse proxy.
Docker Compose makes that possible and the jwilder/nginx-proxy image takes any
need to configure NGINX away.

This simple Docker Compose method is what I used for fast, local feedback whilst
making changes to the Go application code. Within a few seconds I could see if it
didn't build or just didn't work at all.

#### vagrant
Using Vagrant you will have 4 VMs created:
* jenkins_01 - A jenkins server, responsible for building, packaging and delivering
an rpm to a yum repo hosted locally.
* web_01 - An nginx server configured to proxy to the 2 upstream app servers.
* app_01 - An app server running the Go application with supervisor.
* app_02 - An app server running the Go application with supervisor.

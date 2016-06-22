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
You will (eventually) get curl request output. Visit http://localhost:8090 to
see Jenkins in action.

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

#### ???-destroy
Removes the appropriate environment

## Configuration Management
Chef has been used to configure the servers. Initially I fell into what I can
only describe as some sort of monolithic cookbook anti-pattern.

I refactored my chef code into more meaningful cookbooks:
* js-base - base cookbook for application to everything.
* js-nginx - installs nginx and does some very simple config.
* js-jenkins - installs and configures Jenkins.
* js-app - installs everything needed for an "app" server.

Breaking out to separate cookbooks would make it easier to change and test
changes of cookbooks in different environments.

I use Berkshelf to manage cookbook dependencies however not knowing the
environment that this assessment will be run on I have commited the cookbooks
to this repo.

Wherever possible I've tried to make use of community cookbooks using the js-*
cookbooks as wrapper cookbooks. Unfortunately the nginx cookbook caused some
dependency resolution issue that was becoming time consuming to resolve. I had
to fall back to a very simple recipe (install package, replace config, start service).

### TODO: Tests
I'd love to spend a some time writing ServerSpec tests for Kitchen...

## Continuous Delivery
At first it was tempting to just build the Go application on each app server, but
even having that thought made me uneasy. I wanted to build, package and place the
application somewhere that it could be deployed as a package rather than built
by executing scripts or commands via Chef on the app servers. One of the core CI/CD
principles is that you should deploy the same package or artifact through your
pipeline to production (here, there is only one environment).

### Jenkins
I have experience with several CI servers: Bamboo, GoCD, TeamCity and... my
favourite: Jenkins. Chef configures the Jenkins server and creates one job:
jjb-update. The jjb-update job checks out this repo and uses Jenkins Job Builder
to create the app-build, app-package and app-release jobs.

The jobs are configured in a pipeline and trigger as follows:

#### git > app-build > app-package > app-release

The result is an rpm package in a yum repo available from the app servers.

To view the Jenkins Dashboard open: http://localhost:8090 in your browser of choice.

## Code Changes
The original Go application was very simple but I wanted to make a few changes:
* Very simple logging to STDOUT to help in debugging
* Make the port it runs on an environment variable (default: 8484).


## TODO - Deployments
Ideally it would be great to trigger a deployment of a new artifact (yum package)
from Jenkins with Ansible or even something as simple as pssh. I believe this is
outside of the scope of this MVP.

# Note - Everything has bene thrown into one single repo for simplicity of assessment. In reality, this repo would be split into multiple repositories.

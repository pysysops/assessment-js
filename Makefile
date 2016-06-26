.PHONY: help test docker docker-destroy vagrant vagrant-destroy

help:
	@echo "Targets available:"
	@echo "   docker:          Run app in Docker containers (for development use)"
	@echo "   docker-destroy:  Destroy Docker environment"
	@echo "   vagrant:         Create the app in Vagrant"
	@echo "   vagrant-destroy: Destroy Vagrant environment"

docker:
	docker-compose build
	docker-compose up -d
	docker-compose scale app=2
	@sleep 1
	@echo
	curl localhost:8088
	@echo
	curl localhost:8088
	@echo
	curl localhost:8088
	@echo
	curl localhost:8088

docker-destroy:
	docker-compose down

vagrant:
	vagrant up --provision
	@echo
	curl localhost:8080
	@echo
	curl localhost:8080
	@echo
	curl localhost:8080
	@echo
	curl localhost:8080

vagrant-destroy:
	vagrant destroy -f

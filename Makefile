.DEFAULT_GOAL := help
INSTANCE_NAME := graphql-tutorial_web_1
SERVER_ADDRESS := http://localhost:3000

console: ## Jump into the Rails console and interact with the services
	bundle exec rails console
.PHONY: console

run: ## Run the Rails app with an example JSON file locally
	bundle exec rails server
.PHONY: run

test: ## Run the tests
	bundle exec rspec spec
.PHONY: test

generate-swagger-doc: ## Generate Swagger documentation
	bundle exec rake rswag:specs:swaggerize
.PHONY: generate-swagger-doc

docker-setup: ## Sets up the app using Docker and Docker Compose
	docker-compose build
	docker-compose run --rm web bundle exec rails db:create db:migrate
	$(MAKE) docker-run-container
.PHONY: docker-setup

docker-run-container: ## Run the container (one right now)
	docker-compose --file docker-compose.yml up -d
.PHONY: docker-run-container

docker-run-tests: ## Run the tests in the container
	docker-compose run --rm web bundle exec rspec spec
.PHONY: docker-run-tests

docker-remove-container: ## Stops and removes the container
	docker rm -f $(INSTANCE_NAME)
.PHONY: docker-remove-container

docker-hop-on: ## Jump on the docker instance
	docker exec -ti $(INSTANCE_NAME) /bin/bash
.PHONY: docker-hop-on

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

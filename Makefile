TAG := latest
CONTAINER := push-redis
IMAGE := pushaas/$(CONTAINER)
IMAGE_TAGGED := $(IMAGE):$(TAG)
NETWORK := push-service-network
PORT_CONTAINER := 6379
PORT_HOST := 6379

.PHONY: docker-create-network
docker-create-network:
	@-docker network rm $(NETWORK)
	@-docker network create $(NETWORK)

.PHONY: docker-build
docker-build:
	@docker build \
		-t $(IMAGE_TAGGED) \
		.

.PHONY: docker-clean
docker-clean:
	@-docker rm -f $(CONTAINER)

.PHONY: docker-run
docker-run: docker-clean docker-create-network
	@docker run \
		-d \
		--name $(CONTAINER) \
		--network $(NETWORK) \
		-p $(PORT_HOST):$(PORT_CONTAINER) \
		-v push-redis-data:/data \
		$(IMAGE_TAGGED)

.PHONY: docker-build-and-run
docker-build-and-run: docker-build docker-run

.PHONY: docker-push
docker-push: docker-build
	@docker push \
		$(IMAGE_TAGGED)

.PHONY: \
	docker-build \
	docker-run \
	docker-build-and-run \
	docker-push

CONTAINER := push-redis
IMAGE := rafaeleyng/push-redis
IMAGE_TAGGED := $(IMAGE):latest
NETWORK := push-service-network
PORT_CONTAINER := 6379
PORT_HOST := 6380

docker-build:
	@docker build \
		-t $(IMAGE) \
		.

docker-clean:
	@-docker rm -f $(CONTAINER)

docker-run: docker-clean
	@docker run \
		-d \
		--name $(CONTAINER) \
		--network $(NETWORK) \
		-p $(PORT_HOST):$(PORT_CONTAINER) \
		-v push-redis-data:/data \
		$(IMAGE_TAGGED)

docker-build-and-run: docker-build docker-run

docker-push: docker-build
	@docker push \
		$(IMAGE)

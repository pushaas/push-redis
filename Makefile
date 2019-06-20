.PHONY: \
	docker-build \
	docker-run \
	docker-build-and-run \
	docker-push

########################################
# docker
########################################

# prod
docker-build:
	@docker build \
		-t rafaeleyng/push-redis:latest \
		.

docker-run:
	@docker rm -f push-service-redis
	@docker run \
		-d \
		-it \
		--name push-service-redis \
		--network push-service-network \
		-p 6380:6379 \
		-v push-redis-data:/data \
		rafaeleyng/push-redis:latest

docker-build-and-run: docker-build docker-run

docker-push: docker-build
	@docker push \
		rafaeleyng/push-redis

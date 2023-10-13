BUILD_VERSION := $(shell cat VERSION)

.PHONY: build
# Future optimisations --cache-from existing image?
build:
	$(if ${BASE_WSGI_IMAGE_NAME},,$(error Must specify BASE_WSGI_IMAGE_NAME))
	$(eval BUILD_DATE := $(shell date -u '+%Y%m%dT%H%M%SZ'))
	$(eval BUILD_ARGS := --build-arg BUILD_DATE=${BUILD_DATE} --build-arg BUILD_VERSION=${BUILD_VERSION})

	docker build ${BUILD_ARGS} -t ${BASE_WSGI_IMAGE_NAME} wsgi
	docker tag ${BASE_WSGI_IMAGE_NAME} ${BASE_WSGI_IMAGE_NAME}:${BUILD_VERSION}

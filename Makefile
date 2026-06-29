Gemfile.lock: Gemfile
	bundle install

.PHONY: local-serve
local-serve: Gemfile.lock
	bundle exec jekyll serve

.PHONY: local-build
local-build: Gemfile.lock
	bundle exec jekyll build

.PHONY: container-update
container-update:
	podman run \
		--interactive \
		--tty \
		--volume "$(shell pwd)":/data \
		--workdir /data \
		ghcr.io/pstoeckle/docker-images/node-ruby:24.11.1--3.4.7@sha256:4b9e8ff592ab2a7269e9543d6f1723143f9de4302038c9155567e291d9e86a90 \
		sh -c "bundle update"

.PHONY: container-install
container-serve:
	podman run \
		--publish 127.0.0.1:4000:4000 \
		--rm \
		--volume "$(shell pwd)":/data \
		--workdir /data \
		-it \
		ghcr.io/pstoeckle/docker-images/node-ruby:24.11.1--3.4.7@sha256:4b9e8ff592ab2a7269e9543d6f1723143f9de4302038c9155567e291d9e86a90 \
		sh -c "bundle install && bundle exec jekyll serve --host 0.0.0.0"

.PHONY: container-build
container-build:
	podman run \
		--cap-drop all \
		--interactive \
		--tty \
		--volume "$(shell pwd)":/data \
		--workdir /data \
		ghcr.io/pstoeckle/docker-images/node-ruby:24.11.1--3.4.7@sha256:4b9e8ff592ab2a7269e9543d6f1723143f9de4302038c9155567e291d9e86a90 \
		sh -c "bundle install && bundle exec jekyll build --baseurl pstoeckle.codeberg.page"

.DEFAULT_GOAL := local-serve

# Devcontainer Targets: Start
ARCH_RAW := $(shell uname -m)
ARCH := $(if $(filter x86_64 amd64,$(ARCH_RAW)),amd64,$(if $(filter aarch64 arm64,$(ARCH_RAW)),arm64,unknown))

.PHONY: build-and-push-dev-container
build-and-push-dev-container:
	devcontainer build \
		--config .devcontainer/build/devcontainer.json \
		--image-name ghcr.io/pstoeckle/pstoeckle.github.io/devcontainer/$(ARCH):latest \
		--push \
		--workspace-folder .
# Devcontainer Targets: End

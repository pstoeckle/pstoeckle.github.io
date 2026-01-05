.PHONY: local-install local-serve local-build container-serve container-build

local-install: Gemfile Gemfile.lock
	bundle install

local-serve: install-local
	bundle exec jekyll serve

local-build: install-local
	bundle exec jekyll build

container-update:
	podman run \
		--cap-drop all \
		--interactive \
		--tty \
		--volume "$(shell pwd)":/data \
		--workdir /data \
		ghcr.io/pstoeckle/docker-images/node-ruby:24.11.1--3.4.7@sha256:4b9e8ff592ab2a7269e9543d6f1723143f9de4302038c9155567e291d9e86a90 \
		sh -c "bundle update"

container-serve:
	podman run \
		--cap-drop all \
		--publish 127.0.0.1:4000:4000 \
		--read-only \
		--rm \
		--security-opt no-new-privileges \
		--volume "$(shell pwd)":/data \
		--workdir /data \
		-it \
		ghcr.io/pstoeckle/docker-images/node-ruby:24.11.1--3.4.7@sha256:4b9e8ff592ab2a7269e9543d6f1723143f9de4302038c9155567e291d9e86a90 \
		sh -c "bundle install && bundle exec jekyll serve --host 0.0.0.0"

container-build:
	podman run \
		--cap-drop all \
		--interactive \
		--tty \
		--volume "$(shell pwd)":/data \
		--workdir /data \
		ghcr.io/pstoeckle/docker-images/node-ruby:24.11.1--3.4.7@sha256:4b9e8ff592ab2a7269e9543d6f1723143f9de4302038c9155567e291d9e86a90 \
		sh -c "bundle install && bundle exec jekyll build --baseurl pstoeckle.codeberg.page"

.DEFAULT_GOAL := serve-local

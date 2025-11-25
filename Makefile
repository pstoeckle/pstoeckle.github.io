install-local: Gemfile Gemfile.lock
	bundle install

serve-local: install-local
	bundle exec jekyll serve

build-local: install-local
	bundle exec jekyll build

build-with-container:
	podman run \
		--cap-drop all \
		--interactive \
		--publish 127.0.0.1:4000:4000 \
		--tty \
		--volume "$(shell pwd)":/data \
		--workdir /data \
		ghcr.io/pstoeckle/docker-images/node-ruby:24.11.0--3.4.7@sha256:4aa03e3fa85c7f76d3d908f599c8efb4745a6c5f922aded509aa702e538375ba \
		sh -c "bundle install && bundle exec jekyll serve --host 0.0.0.0"

.DEFAULT_GOAL := serve-local

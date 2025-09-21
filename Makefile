install-local: Gemfile Gemfile.lock
	bundle install

serve-local: install-local
	bundle exec jekyll serve

build-local: install-local
	budle exec jekyll build

build-with-container:
	docker run \
		--cap-drop all \
		--interactive \
		--tty \
		--volume "$(shell pwd)":/data \
		--workdir /data \
		ghcr.io/pstoeckle/docker-images/node-ruby:24.8.0--3.3@sha256:248fa74b2728eb33ac674498be5bdac3750c08f177ce9a9c10bb8e74034380db \
		sh -c "bundle exec jekyll serve"

.DEFAULT_GOAL := serve-local

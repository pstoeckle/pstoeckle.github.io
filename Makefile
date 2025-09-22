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
		--tty \
		--volume "$(shell pwd)":/data \
		--workdir /data \
		ghcr.io/pstoeckle/docker-images/node-ruby:24.8.0--3.4.6@sha256:b83cf63b7672f501bcdb1919e26b52b871d67dcdd696691770970df751b5d768 \
		sh -c "bundle exec jekyll serve"

.DEFAULT_GOAL := serve-local

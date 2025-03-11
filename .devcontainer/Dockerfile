FROM node:19.1.0

LABEL author="Patrick Stöckle <patrick.stoeckle+docker@posteo.de>"

RUN apt-get update -qq \
    && apt-get install -qq --no-install-recommends -y \
        bash-completion \
        ruby-bundler=2.2.5-2 \
        ruby-dev=1:2.7+2 \
        ruby=1:2.7+2 \
        vim \
    && apt-get autoremove -y -qq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g npm@9.1.2 \
    && addgroup --gid 2000 bundle-user \
    && useradd \
      --create-home \
      --gid 2000 \
      --home-dir /home/bundle-user \
      --shell /bin/bash \
      --uid 2000 \
      bundle-user \
    && echo "source /usr/share/bash-completion/completions/git" > /home/bundle-user/.bashrc \
    && chown bundle-user:bundle-user /home/bundle-user/.bashrc

USER bundle-user

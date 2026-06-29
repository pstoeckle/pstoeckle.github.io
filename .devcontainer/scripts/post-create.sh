#!/bin/sh
set -eu

# Fix ownership for bash history volume
sudo chown -R "$(whoami):" /commandhistory

# Fix ownership for node_modules
sudo chown -R "$(whoami):" node_modules

sudo chown -R "$(whoami):" _vendor

# Set up bash history to use a docker volume for persistence
{
    echo "# Set HISTFILE to docker volume " ;
    echo "export PROMPT_COMMAND='history -a'" ;
    echo "export HISTFILE=/commandhistory/.bash_history" ;
} >> "$HOME/.bashrc"

# Add any additional commands you want to run each time the container is created here.

sudo npm install -g npm

npm install

bundle install

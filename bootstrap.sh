#!/bin/sh

echo "checking for homebrew updates";
brew update

function install_current {
  echo "trying to update $1"
  # https://docs.travis-ci.com/user/reference/osx/
  # avoids errors
  brew upgrade $1 || brew install $1 || true
  brew link $1
}

if [ -e "Mintfile" ]; then
  install_current mint
  mint bootstrap
fi

# Install ruby if a .ruby-version exists
if [ -e ".ruby-version" ]; then
  echo "installing ruby version";

  brew install rbenv
  brew install ruby-build
  # install ruby version from .ruby-version, skipping if already installed (-s)
  rbenv install -s
fi

# Install gems if a Gemfile exists
if [ -e "Gemfile" ]; then
  echo "installing ruby gems";

  # install bundler gem for ruby dependency management
  gem install bundler --no-document || echo "failed to install bundle";
  bundle config set deployment 'true';
  bundle config path vendor/bundle;
  bundle install --jobs 4 --retry 3 || echo "failed to install bundle";
fi

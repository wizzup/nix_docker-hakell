[![Build Status](https://travis-ci.com/wizzup/nix_docker-hakell.svg?branch=master)](https://travis-ci.com/wizzup/nix_docker-hakell)

# Haskell Stack, Docker and Nix

STATUS:: **Work in progress**

`Docker` image contains `stack` building using `Nix`

Inspire by https://github.com/jkachmar/alpine-haskell-stack, I want to see if `Nix` can build similar docker image.

By using `nix` the unused/unnecessary part (e.g. package management) will not need to be in the docker image.


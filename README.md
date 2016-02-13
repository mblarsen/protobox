# Protobox

[![Get help on Codementor](https://cdn.codementor.io/badges/get_help_github.svg)](https://www.codementor.io/mblarsen?utm_source=github&utm_medium=button&utm_term=mblarsen&utm_campaign=github) [![Join the chat at https://gitter.im/mblarsen/arrgh](https://badges.gitter.im/mblarsen/protobox.svg)](https://gitter.im/mblarsen/protobox?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

A simple box for prototyping ideas. 

- nginx (setup as proxy)
- Slim 3 (with Eloquent) / Laravel 5.x pre-configured
- MySQL (with user and db created based on project)

# How to use

Run the install:

    ./install.sh

Optionally you can have a repo ready and the install script will configure remotes.

[![demo](https://asciinema.org/a/9nkten79gmtgxxxxvpro4w5kr.png)](https://asciinema.org/a/9nkten79gmtgxxxxvpro4w5kr)

# TODO

- [x] Consider setting `user` and `group` in `/etc/php5/fpm/pool.d/www.conf` to `vagrant`
- [x] Configure `.env` file for Laravel and similar for Slim

# Protobox

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

# Docker config for local Laravel development

This is a template package for building a local development 
environment suited for Laravel based projects.

### Included services and tools:
- apache 2.4
- php 8.4 with FPM
- MySQL 9.2
- phpMyAdmin 5.2
- MailPit 1.22
- Memcached 1.6
- xDebug
- Composer

### Compatible with Traefik router
If you are using Traefik on local it has all the needed labels
in `traefik.docker-compose.yml`.

### Running without Traefik (exposed ports)
`make ports`

### Running with Traefik routers (no exposed ports)
`make traefik` or `make up`

### PHP configuration
If any php.ini settings needs to be changed, edit the file in
`_setup/php/php-overrides.ini` and run `make restart`.

### Enabling xDebug
Change the `xdebug.mode` value in `_setup/php/php-overrides.ini` to your 
desired mode, and run `make restart`.

### Traefik URLs:
```
http://${TRAEFIK_DOMAIN} - your project
http://pma.${TRAEFIK_DOMAIN} - phpMyAdmin
http://mailpit.${TRAEFIK_DOMAIN} - Mailpit interface
```

### Ports:
```
http://localhost - your project
http://localhost:8001 - phpMyAdmin
http://localhost:8002 - MailPit
```

### SLL
Currently, no SSL is supported.

### Makefile commands:
- `make ports` - run containers with exposed ports
- `make traefik` or `make up` - run containers with Traefik labels, no exposed ports
- `make restart` - restart the containers
- `make stop` - stop all containers
- `make down` - stop and remove all containers and their name and anonymous volumes
- `make cleanup` - remove all containers, volumes, persistent volumes, and orphans
- `make rebuild-traefik` and `make rebuild-ports` - rebuild containers
- `make status` - displays table showing status of all services
- `make php-shell` - enter php_fpm bash with interactive mode, to use artisan or composer
- `make php-ext-list` - shows the list of installed php's extensions
- `make logs` - show containers logs in follow mode
- `make dump-db` - dumps a database into _dumps directory
- `make test-config-traefik` and `make test-config-ports` - shows the Docker config to be used
- `make laravel-init` - install latest Laravel version into `src` dir. Note: it removes the `src/public` directory. If you've put anything else in there, make sure the `src` dir is empty before running this.
- `make site-off` - put Laravel in maintenance mode
- `make site-on` - put Laravel online again
- `make clear-cache` - clear Laravel caches
- `make deploy` - put Laravel in maintenance mode, clear caches, migrate database, restore caches, put it back online 
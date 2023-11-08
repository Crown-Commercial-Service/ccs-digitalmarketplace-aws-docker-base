# ccs-digitalmarketplace-aws-docker-base

New base Docker builds for provision of DMP in native AWS.

Adapted from the original configurations found in [the original DMP Docker base project](https://github.com/Crown-Commercial-Service/digitalmarketplace-docker-base).

# Rationale

The previous architecture of "supervisord + nginx + uwsgi in socket mode + awslogs" does not fit the provision model well for ECS Fargate tasks. This architecture is baked in to each service by means of [the base Docker builds](https://github.com/Crown-Commercial-Service/digitalmarketplace-docker-base/blob/main/base.docker). Hence this repo has been created to replace these for native AWS installations of DMP.

There are fours types of Docker base image created by this repo:

* _wsgi_ - uWSGI running in httpsocket mode, delivering the app backend
* _http-headless_ - Nginx server acting as reverse proxy to _wsgi_ container 
* _http-frontend_ - Nginx server acting as reverse proxy to _wsgi_ container and providing direct service of static files from the app
* _http-buildstatic_ - This is a Node-based image which is used temporarily to build the static assets for frontend sites

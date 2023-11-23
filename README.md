# ccs-digitalmarketplace-aws-docker-base

New base Docker builds for provision of DMP in native AWS.

Adapted from the original configurations found in [the original DMP Docker base project](https://github.com/Crown-Commercial-Service/digitalmarketplace-docker-base).

# Rationale

The previous architecture of "supervisord + nginx + uwsgi in socket mode + awslogs" does not fit the provision model well for ECS Fargate tasks. This architecture is baked in to each service by means of [the base Docker builds](https://github.com/Crown-Commercial-Service/digitalmarketplace-docker-base/blob/main/base.docker). Hence this repo has been created to replace these for native AWS installations of DMP.

There are fours types of Docker base image created by this repo:

* _wsgi_ - uWSGI running in httpsocket mode, delivering the app backend
* _wsgi-antivirus_ - uWSGI running in httpsocket mode, delivering the antivirus api backend (see [Why the Antivirus API uses a different uWSGI image](#why-the-antivirus-api-uses-a-different-uwgsi-image))
* _http-headless_ - Nginx server acting as reverse proxy to _wsgi_ container 
* _http-frontend_ - Nginx server acting as reverse proxy to _wsgi_ container and providing direct service of static files from the app
* _http-buildstatic_ - This is a Node-based image which is used temporarily to build the static assets for frontend sites

## Why the Antivirus API uses a different uWSGI image

There is a recently-discovered bug (Oct 2023) in the libcrypto package (source [Python Connector fails to connect with 'LibraryNotFoundError: Error detecting the version of libcrypto'](https://community.snowflake.com/s/article/Python-Connector-fails-to-connect-with-LibraryNotFoundError-Error-detecting-the-version-of-libcrypto)):

> The issue occurs due to a combination of the following conditions involving dependencies of the Snowflake Python Connector:
> - Use of OpenSSL 3.0.10 or later 3.0.x (with x >= 10), and
> - Use of Python PyPI package oscrypto version 1.3.0 or earlier
>
> Specifically, an issue in oscrypto 1.3.0 and earlier releases causes it to fail when encountering OpenSSL release versions with a multi-digit patch level version (such as the '10' in '3.0.10').

There is a discussion around this issue on [GitHub](https://github.com/wbond/oscrypto/issues/78) however, a new release does not seem to be forthcoming.

As such, for now, we will use a base image with an older version of debian `python:3.9-slim-buster`, instead of `python:3.9-slim-bookworm` which we use for all the other apps.

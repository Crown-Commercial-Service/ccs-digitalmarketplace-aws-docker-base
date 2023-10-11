# ccs-digitalmarketplace-aws-docker-base

New base Docker builds for provision of DMP in native AWS.

Adapted from the original configurations found in [the original DMP Docker base project](https://github.com/Crown-Commercial-Service/digitalmarketplace-docker-base).

# Rationale

The previous architecture of "supervisord + nginx + uwsgi in socket mode + awslogs" does not fit the provision model well for ECS Fargate tasks. This architecture is baked in to each service by means of [the base Docker builds](https://github.com/Crown-Commercial-Service/digitalmarketplace-docker-base/blob/main/base.docker). Hence this repo has been created to replace these for native AWS installations of DMP.

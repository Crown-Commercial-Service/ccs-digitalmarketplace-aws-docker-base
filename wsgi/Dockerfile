# Python pinned as per original project
FROM python:3.9-alpine

ENV APP_DIR=/app
ENV DEP_PYUWSGI_VERSION=2.0.22

ARG BUILD_DATE
ARG BUILD_VERSION
LABEL BUILD_DATE=${BUILD_DATE}
LABEL BUILD_VERSION=${BUILD_VERSION}

WORKDIR ${APP_DIR}
RUN addgroup -r uwsgi && adduser --no-log-init -r -g uwsgi && \
    apk add --no-cache python3 -m venv && \
    pip3 install --no-cache-dir --upgrade pip pyuwsgi==${DEP_PYUWSGI_VERSION}

COPY mime.types /etc/mime.types

CMD ["/app/venv/bin/uwsgi", "--http-socket", ":8888", "--master", "-w", "application:application"]
EXPOSE 8888

ONBUILD ARG release_name
ONBUILD COPY requirements.txt ${APP_DIR}
ONBUILD RUN echo ${release_name} > ${APP_DIR}/version_label && \
            apk add update && \
            apk add install -y curl gcc git libffi-dev && \
            pip3 install --no-cache-dir --upgrade pip -r requirements.txt
ONBUILD COPY --chown=uwsgi:uwsgi . ${APP_DIR}
ONBUILD USER uwsgi

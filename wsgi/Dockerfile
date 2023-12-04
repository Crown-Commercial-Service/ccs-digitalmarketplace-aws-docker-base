# Python pinned as per original project
FROM python:3.9-slim-bookworm

ENV APP_DIR=/app
ENV DEP_PYUWSGI_VERSION=2.0.22

ARG BUILD_DATE
ARG BUILD_VERSION
LABEL BUILD_DATE=${BUILD_DATE}
LABEL BUILD_VERSION=${BUILD_VERSION}

WORKDIR ${APP_DIR}
RUN /usr/sbin/groupadd -r uwsgi && \
    /usr/sbin/useradd --no-log-init -r -g uwsgi uwsgi && \
    /usr/local/bin/python3 -m venv venv && \
    /app/venv/bin/pip3 install --no-cache-dir --upgrade pip && \
    /app/venv/bin/pip3 install --no-cache-dir pyuwsgi==${DEP_PYUWSGI_VERSION}

COPY mime.types /etc/mime.types

CMD ["/app/venv/bin/uwsgi", "--http-socket", ":8888", "--master", "-w", "application:application"]
EXPOSE 8888

ONBUILD ARG release_name
ONBUILD COPY requirements.txt ${APP_DIR}
ONBUILD RUN echo ${release_name} > ${APP_DIR}/version_label && \
            apt-get update && \
            apt-get install -y curl gcc git libffi-dev && \
            /app/venv/bin/pip3 install --no-cache-dir --upgrade pip && \
            /app/venv/bin/pip3 install --no-cache-dir -r requirements.txt
ONBUILD COPY --chown=uwsgi:uwsgi . ${APP_DIR}
ONBUILD USER uwsgi

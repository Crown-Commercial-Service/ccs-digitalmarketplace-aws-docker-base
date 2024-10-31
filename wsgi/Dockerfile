# Python pinned as per original project
FROM python:3.12-alpine

ENV APP_DIR=/app
ENV DEP_PYUWSGI_VERSION=2.0.22
# Add the venv bin directory to the path. Once the venv is created, it will be the preferred location for python3, pip3 and uwsgi
ENV PATH="/$APP_DIR/venv/bin:$PATH"

ARG BUILD_DATE
ARG BUILD_VERSION
LABEL BUILD_DATE=${BUILD_DATE}
LABEL BUILD_VERSION=${BUILD_VERSION}

WORKDIR ${APP_DIR}
RUN addgroup -S uwsgi && adduser -S -H -G uwsgi uwsgi && \
    python3 -m venv /app/venv && \
    pip3 install --no-cache-dir --upgrade pip setuptools pyuwsgi==${DEP_PYUWSGI_VERSION}

COPY mime.types /etc/mime.types

CMD ["uwsgi", "--http-socket", ":8888", "--processes", "4", "--enable-threads", "--buffer-size", "16384", "--single-interpreter", "--reload-on-rss", "256", "--disable-logging", "--harakiri", "60", "--master", "-w", "application:application"]
EXPOSE 8888

ONBUILD ARG release_name
ONBUILD COPY requirements.txt ${APP_DIR}
ONBUILD RUN echo ${release_name} > ${APP_DIR}/version_label && \
            apk upgrade && apk add aws-cli build-base curl git libffi libffi-dev && rm -rf /var/cache/apk && \
            pip3 install --no-cache-dir --upgrade pip setuptools -r requirements.txt && \
            apk del build-base libffi-dev && rm -rf /root/.cache
ONBUILD COPY --chown=uwsgi:uwsgi . ${APP_DIR}
ONBUILD USER uwsgi

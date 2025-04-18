FROM alpine:3.20

ARG APP_USER=skills
ARG APP_UID=1001
ARG LOG_DIRECTORY='./log'

WORKDIR /app

RUN apk add --no-cache curl gcompat
RUN adduser -D -u ${APP_UID} ${APP_USER}
COPY --chown=${APP_UID}:${APP_UID} stress-amd64 .
RUN mkdir -p ${LOG_DIRECTORY}
RUN chown -R ${APP_UID}:${APP_UID} /app && \
    chmod +x stress-amd64
RUN ln -sf /dev/stdout ${LOG_DIRECTORY}/app.log

USER ${APP_UID}:${APP_UID}
VOLUME ["${LOG_DIRECTORY}"]

ENTRYPOINT ["/app/stress-amd64"]

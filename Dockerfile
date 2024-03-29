FROM alpine

RUN apk update && apk add --no-cache \
    bash \
    curl \
    inotify-tools \
    openssh-client

# https://github.com/socheatsok78/s6-overlay-installer
ARG S6_OVERLAY_VERSION=v3.1.6.2
ARG S6_OVERLAY_INSTALLER=main/s6-overlay-installer-minimal.sh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/socheatsok78/s6-overlay-installer/${S6_OVERLAY_INSTALLER})"

# https://github.com/vishnubob/wait-for-it
ADD --chmod=0755 https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /usr/local/bin/wait-for-it

ADD rootfs /
VOLUME [ "/keys.d" ]
ENTRYPOINT [ "/init-shim", "/docker-entrypoint.sh"]

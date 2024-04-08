FROM alpine:3 AS download
RUN apk add --no-cache curl tar gzip
WORKDIR /build
ARG VERSION_TAG
RUN curl -L https://github.com/MCSManager/MCSManager/releases/download/${VERSION_TAG}/mcsmanager_linux_release.tar.gz | tar -xvz

FROM node:lts

WORKDIR /mnt/user/appdata/mcsm/daemon

COPY --from=download /build/daemon/ /mnt/user/appdata/mcsm/daemon/

RUN npm install --production

EXPOSE 24444

VOLUME ["/mnt/user/appdata/mcsm/daemon/data", "/mnt/user/appdata/mcsm/daemon/logs"]

CMD [ "app.js", "--max-old-space-size=8192" ]

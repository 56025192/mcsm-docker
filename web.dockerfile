FROM alpine:3 AS download
RUN apk add --no-cache curl tar gzip
WORKDIR /build
ARG VERSION_TAG
RUN curl -L https://github.com/MCSManager/MCSManager/releases/download/${VERSION_TAG}/mcsmanager_linux_release.tar.gz | tar -xvz

FROM node:lts

WORKDIR /mnt/user/appdata/mcsm/web

COPY --from=download /build/web/ /mnt/user/appdata/mcsm/web/

RUN npm install --production

EXPOSE 23333

VOLUME ["/mnt/user/appdata/mcsm/web/data", "/mnt/user/appdata/mcsm/web/logs"]

CMD [ "app.js", "--max-old-space-size=8192" ]

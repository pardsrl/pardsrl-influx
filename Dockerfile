FROM keymetrics/pm2:8-alpine

WORKDIR /srv/node-scripts/
# Bundle APP files
COPY pardsrl-influx-api/package.json pardsrl-influx-api/package.json
COPY pardsrl-influx-db/package.json pardsrl-influx-db/package.json
COPY ecosystem.config.js .

# Install app dependencies
ENV NPM_CONFIG_LOGLEVEL warn

# RUN apk add --update \
#     python \
#     build-base \
#     && rm -rf /var/cache/apk/*

RUN cd pardsrl-influx-api \
    && npm install --production

# Expose the listening port of your app
EXPOSE 8081

CMD [ "pm2-runtime", "start", "ecosystem.config.js" ]

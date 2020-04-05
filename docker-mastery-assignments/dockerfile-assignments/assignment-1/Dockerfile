FROM node:6-alpine

ENV NODE_ENV=production, NPM_CONFIG_LOGLEVEL=info

RUN apk add --update tini

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY package.json package.json

RUN npm install && npm cache clean --force

COPY ./ ./

EXPOSE 80

CMD [ "/sbin/tini","--","node","./bin/www" ]
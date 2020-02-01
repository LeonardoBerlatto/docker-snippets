FROM node

ENV NODE_ENV=production

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY package.json package.json

RUN npm install && npm cache clean --force

# use with docker ignore
COPY ./ ./

EXPOSE 3000

CMD ["node","index.js"]
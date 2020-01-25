FROM node

ENV NODE_ENV=production

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY index.js index.js

EXPOSE 3000

CMD ["node","index.js"]
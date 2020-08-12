FROM node:10 AS build
WORKDIR /usr/src/app

COPY .babelrc ./
COPY package*.json ./
COPY webpack.server.build.config.js ./
COPY webpack.client.build.config.js ./
COPY webpack.server.config.js ./
COPY webpack.client.config.js ./
COPY src src
COPY assets assets
RUN npm install
RUN npm run build


FROM node:10
WORKDIR /usr/src/app

COPY --from=build /usr/src/app/package.json package.json
COPY --from=build /usr/src/app/dist dist
COPY .sequelizerc ./
COPY ./src/server/config ./src/server/config
COPY ./src/server/database ./src/server/database
COPY ./src/server/migrations ./src/server/migrations
COPY ./src/server/config ./src/server/config

RUN npm install --only=production
RUN npm install -g sequelize-cli

EXPOSE 8000
CMD [ "npm", "run", "server:production" ]

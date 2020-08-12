FROM node:10 AS build
WORKDIR /usr/src/app
COPY .babelrc ./
COPY package*.json ./
COPY webpack.server.build.config.js ./
COPY webpack.client.build.config.js ./
COPY webpack.server.config.js ./
COPY webpack.client.config.js ./
COPY .sequelizerc ./

COPY src src
COPY assets assets
RUN npm install
# RUN npm run build
RUN npm install 
RUN npm install -g sequelize-cli
EXPOSE 8001
CMD [ "npm", "run", "server" ]


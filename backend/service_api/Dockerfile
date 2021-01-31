FROM node:15-alpine

WORKDIR /usr/service
COPY package.json yarn.lock ./

RUN yarn

COPY . .

EXPOSE 3334
CMD [ "yarn", "start"]
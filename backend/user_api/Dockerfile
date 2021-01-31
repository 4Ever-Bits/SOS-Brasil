FROM node

WORKDIR /usr/user
COPY package.json yarn.lock ./

RUN yarn

COPY . .

EXPOSE 3333
CMD [ "yarn", "start"]
FROM node:14

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install -silent

COPY . .

EXPOSE 8700
CMD ["npm","run","start"]
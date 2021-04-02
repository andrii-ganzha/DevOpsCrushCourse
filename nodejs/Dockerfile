FROM node:14
WORKDIR /home/ganzha_as/Course/nodejs
COPY package*.json app.js ./
RUN npm install
EXPOSE 3000
CMD ["node", "app.js"]

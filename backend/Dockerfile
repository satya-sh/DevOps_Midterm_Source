FROM node:18
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
# COPY wait-for-db.sh /app/wait-for-db.sh
# RUN chmod +x /app/wait-for-db.sh
EXPOSE 8800
CMD ["npm", "start"]

FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx

# copy files from the previous phase
COPY --from=builder /app/build /usr/share/nginx/html

# no need to specifically start nginx, it's started by default by this image
FROM node:16 as builder
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm install -g http-server && npm run build

FROM nginx:latest
RUN apt update && apt install -y curl debian-keyring debian-archive-keyring apt-transport-https
COPY --from=builder /usr/src/app/dist/frontend/. /usr/share/nginx/html/
EXPOSE 8080
FROM node:24-alpine AS build
WORKDIR /app
COPY website/package.json website/package-lock.json ./
RUN npm ci
COPY website/ .
RUN npm run build

FROM nginx:alpine
COPY website/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80

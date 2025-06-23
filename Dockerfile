FROM node:24.1.0-alpine AS build

WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build

FROM nginx:1.28.0-alpine AS server
COPY --from=build /app/dist/utils/browser /usr/share/nginx/html
COPY /nginx.conf  /etc/nginx/conf.d/default.conf
EXPOSE 80
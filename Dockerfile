FROM node:24.1.0-alpine@sha256:91aa1bb6b5f57ec5109155332f4af2aa5d73ff7b4512c8e5dfce5dc88dbbae0e AS build

WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build

FROM nginx:1.28.0-alpine@sha256:aed99734248e851764f1f2146835ecad42b5f994081fa6631cc5d79240891ec9 AS server
COPY --from=build /app/dist/utils/browser /usr/share/nginx/html
COPY /nginx.conf  /etc/nginx/conf.d/default.conf
EXPOSE 80
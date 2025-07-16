FROM node:24.1.0-alpine@sha256:91aa1bb6b5f57ec5109155332f4af2aa5d73ff7b4512c8e5dfce5dc88dbbae0e AS build

WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build

FROM nginx:1.28.0-alpine@sha256:94408aa6adc1b04bd7d0ebdb3ffcc09ee867cf7b94927cffc35634e5d2dce08b AS server
COPY --from=build /app/dist/utils/browser /usr/share/nginx/html
COPY /nginx.conf  /etc/nginx/conf.d/default.conf
EXPOSE 80
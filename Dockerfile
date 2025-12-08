FROM node:24.11.0-alpine@sha256:f36fed0b2129a8492535e2853c64fbdbd2d29dc1219ee3217023ca48aebd3787 AS build

WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build

FROM nginx:1.29.3-alpine@sha256:b3c656d55d7ad751196f21b7fd2e8d4da9cb430e32f646adcf92441b72f82b14 AS server
COPY --from=build /app/dist/utils/browser /usr/share/nginx/html
COPY /nginx.conf  /etc/nginx/conf.d/default.conf
EXPOSE 80
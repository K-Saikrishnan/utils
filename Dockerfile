FROM node:24.8.0-alpine@sha256:3e843c608bb5232f39ecb2b25e41214b958b0795914707374c8acc28487dea17 AS build

WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build

FROM nginx:1.29.1-alpine@sha256:42a516af16b852e33b7682d5ef8acbd5d13fe08fecadc7ed98605ba5e3b26ab8 AS server
COPY --from=build /app/dist/utils/browser /usr/share/nginx/html
COPY /nginx.conf  /etc/nginx/conf.d/default.conf
EXPOSE 80
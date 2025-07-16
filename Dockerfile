FROM node:24.2.0-alpine@sha256:7aaba6b13a55a1d78411a1162c1994428ed039c6bbef7b1d9859c25ada1d7cc5 AS build

WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build

FROM nginx:1.29.0-alpine@sha256:f741b7f2e82ec8e3daa163b089d48ec163ad0b015d859a1e4f0f2a6202e8cc22 AS server
COPY --from=build /app/dist/utils/browser /usr/share/nginx/html
COPY /nginx.conf  /etc/nginx/conf.d/default.conf
EXPOSE 80
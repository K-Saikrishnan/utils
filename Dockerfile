FROM node:24.2.0-alpine@sha256:7aaba6b13a55a1d78411a1162c1994428ed039c6bbef7b1d9859c25ada1d7cc5 AS build

WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build

FROM nginx:1.29.0-alpine@sha256:d67ea0d64d518b1bb04acde3b00f722ac3e9764b3209a9b0a98924ba35e4b779 AS server
COPY --from=build /app/dist/utils/browser /usr/share/nginx/html
COPY /nginx.conf  /etc/nginx/conf.d/default.conf
EXPOSE 80
FROM node:24.5.0-alpine@sha256:e8e882c692a08878d55ec8ff6c5a4a71b3edca25eda0af4406e2a160d8a93cf2 AS build

WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build

FROM nginx:1.29.1-alpine@sha256:42a516af16b852e33b7682d5ef8acbd5d13fe08fecadc7ed98605ba5e3b26ab8 AS server
COPY --from=build /app/dist/utils/browser /usr/share/nginx/html
COPY /nginx.conf  /etc/nginx/conf.d/default.conf
EXPOSE 80
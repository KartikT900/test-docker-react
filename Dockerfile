FROM node:alpine as buildPhase
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# exposing port 80 from the docker container. EBS looks
# at this 'expose' variable and will automatically do the port mapping. This is not equivalent to
# -p 8000:80 or -p 8000:8080 when running in local.
EXPOSE 80
COPY --from=buildPhase /app/build /usr/share/nginx/html
# FROM node:alpine3.18 as build
# WORKDIR /app
# COPY package.json .
# RUN npm install
# COPY . .
# RUN npm run build


# FROM nginx:1.23-alpine
# WORKDIR /usr/share/nginx/html
# RUN rm -rf *
# COPY --from=build /app/dist .
# EXPOSE 80
# ENTRYPOINT [ "nginx", "-g", "daemon off;" ]


FROM node:latest as node

WORKDIR /app

COPY . .

RUN npm install --force
RUN npm run build --prod

FROM nginx:alpine

COPY --from=node /app/dist /usr/share/nginx/html

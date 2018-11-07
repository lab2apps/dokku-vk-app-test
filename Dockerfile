# build environment
FROM node:alpine as builder
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
ENV NODE_ENV development
RUN yarn
COPY . ./
RUN yarn build

# production environment
FROM nginx:alpine
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

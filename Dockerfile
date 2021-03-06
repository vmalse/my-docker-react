FROM node:alpine as builder
# we are tagging the phase so everything under this can be reffered by builder

WORKDIR '/app'
COPY package*.json ./ 
RUN npm install
COPY . .
RUN npm run build

#build folder will be created inside of the working directory and that is the folder that we care about /app/build

#run phase for running nginx

FROM nginx
EXPOSE 80
# this also states that previous block is complete
COPY  --from=builder /app/build /usr/share/nginx/html
#using this container will be-default take care of starting up nginx in nginx image itself

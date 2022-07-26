FROM node

COPY ./ /src/

WORKDIR /src/

RUN npm install http-server -g

CMD ["http-server", "./", "-p", "3000", "--cors", "-c1"]
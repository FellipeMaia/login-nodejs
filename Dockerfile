FROM node:18-bullseye as base
ENV APPDIR=/app
RUN mkdir $APPDIR
WORKDIR $APPDIR

FROM base as development

RUN npm install -g nodemon

EXPOSE 5001

CMD ["yarn", "dev:start"]

FROM base as production

EXPOSE 8080

COPY package.json ./
COPY yarn.lock ./
COPY ./src ./src

RUN npm install --silent --progress=false

ENV ENVIRONMENT=PRD \
    PATH_LOG=logs

CMD ["yarn", "start"]
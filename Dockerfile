FROM node:18-bullseye
ENV APPDIR=/app
RUN echo $USER
WORKDIR $APPDIR

FROM base as development

EXPOSE 5001

COPY package.json ./
COPY yarn.lock ./
COPY ./src ./src

RUN npm install --silent --progress=false

ENV ENVIRONMENT=DEV \
    PATH_LOG=logs

CMD ["yarn", "dev.start"]
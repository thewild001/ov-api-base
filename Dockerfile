FROM node:16.18.0-buster-slim as node

LABEL app.author="fortes" app.email="fortes@uci.cu" app.name="aspirante-api"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        python3 python3-pip \
        libpq-dev openssh-client curl ca-certificates  \
        gettext nano \
 && rm -rf /var/lib/apt/lists/*


RUN ln -fs /usr/share/zoneinfo/America/Havana /etc/localtime && dpkg-reconfigure -f noninteractive tzdata


ARG ENV=staging
ARG APP=api
ENV ENV ${ENV}
ENV APP ${APP}

# Define the workdir for the app
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package.json .
RUN npm install




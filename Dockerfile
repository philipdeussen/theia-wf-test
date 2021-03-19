FROM node:12.21-buster

ARG N_USER="node"

USER root


RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    && apt-get install -y --no-install-recommends \
    software-properties-common \
    locales \
    gnupg \
    dirmngr \
    git \
    wget \
    inkscape \
    lmodern \
    texlive-latex-extra \
    latexmk \
    make \
    biber \
    perl \
    tzdata \
    unzip \
    fonts-dejavu \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


SHELL ["/bin/bash", "-o", "pipefail", "-c"]


RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

USER node

RUN mkdir -p /home/$N_USER/theia \
    && mkdir -p /home/$N_USER/project \
    && mkdir /home/$N_USER/theia/plugins
ENV HOME /home/$N_USER/theia

COPY package.json /home/$N_USER/theia/

WORKDIR $HOME

RUN yarn --pure-lockfile && \
    NODE_OPTIONS="--max_old_space_size=4096" yarn theia build && \
    yarn theia download:plugins && \
    yarn --production && \
    yarn autoclean --init && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \
    yarn autoclean --force && \
    yarn cache clean

EXPOSE 3000 8888
ENV SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/$N_USER/theia/plugins
ENV USE_LOCAL_GIT true
ENTRYPOINT [ "node", "/home/node/theia/src-gen/backend/main.js", "/home/node/project", "--hostname=0.0.0.0" ]

ARG ELIXIR_VERSION=1.15.6
ARG ERLANG_VERSION=26.1.1
ARG UBUNTU_VERSION=jammy-20230126
FROM hexpm/elixir:${ELIXIR_VERSION}-erlang-${ERLANG_VERSION}-ubuntu-${UBUNTU_VERSION}

# for phx.new
ARG PHOENIX_VERSION="1.7.8"
RUN DEBIAN_FRONTEND=nointeractive \
    && apt-get update \
    && apt-get -y install --no-install-recommends \
    curl \
    unzip \
    # features
    && curl -sSL https://github.com/devcontainers/features/archive/refs/heads/main.zip -o /tmp/features-main.zip \
    && unzip /tmp/features-main.zip -d /tmp \
    # features/common-utils
    && INSTALLZSH=false \
    CONFIGUREZSHASDEFAULTSHELL=false \
    INSTALLOHMYZSH=false \
    INSTALLOHMYZSHCONFIG=false \
    UPGRADEPACKAGES=true \
    USERNAME=vscode \
    UID=1000 \
    GID=1000 \
    NONFREEPACKAGES=false \
    /bin/bash /tmp/features-main/src/common-utils/install.sh \
    # features/github-cli
    && VERION=latest \
    && /bin/bash /tmp/features-main/src/github-cli/install.sh \
    # Clean Up
    && apt-get -y autoremove \ 
    && apt-get -y clean \ 
    && rm -rf /var/lib/apt/lists/* /tmp/*
    # Phoenix
    RUN su vscode -c "mix local.hex --force \ 
    && mix local.rebar --force \
    && mix archive.install hex phx_new --force $PHOENIX_VERSION" 
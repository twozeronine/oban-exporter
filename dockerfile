ARG UBUNTU_VERSION=ubuntu-jammy-20230126
FROM hexpm/elixir:1.15.6-erlang-26.1.1-${UBUNTU_VERSION} as builder
ARG _MIX_ENV

RUN apt-get update
WORKDIR /src
COPY . .
RUN mix local.hex --force
RUN mix deps.get

# Create a Mix.Release of the application
RUN MIX_ENV=${_MIX_ENV} mix release
RUN mv _build/${_MIX_ENV}/rel/oban_exporter /opt/release
RUN mv /opt/release/bin/oban_exporter /opt/release/bin/app

FROM ubuntu:jammy-20230126 as runner
RUN apt-get update -y \
    && apt-get -y install --no-install-recommends \ 
    locales \
    && locale-gen en_US.UTF-8 \
    # Clean UP
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*_* 
ENV LANG=C.UTF-8
WORKDIR /opt/release
COPY --from=builder /opt/release .
CMD /opt/release/bin/app start
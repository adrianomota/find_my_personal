FROM elixir:1.11.4-alpine AS build

RUN apt-get upgrade && apt-get update --no-cache build-base npm git python

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

ENV MIX_ENV=prod

COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

COPY assets/package.json assets/package-lock.json ./assets/
RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

COPY priv priv
COPY assets assets
RUN npm run --prefix ./assets deploy
RUN mix phx.digest

COPY lib lib

RUN mix do compile, release


FROM alpine:3.9 AS app

RUN apt-get upgrade && apt-get update --no-cache build-base --no-cache openssl ncurses-libs


WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/find_my_personal ./

ENV HOME=/app

CMD ["bin/find_my_personal", "start"]
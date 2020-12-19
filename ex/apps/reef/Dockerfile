FROM elixir:latest as builder
COPY apps/reef/ /app
WORKDIR /app

COPY config/ /app/config/
COPY mix.exs /app/
COPY mix.* /app/

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get
RUN MIX_ENV=prod mix release


FROM elixir:alpine
WORKDIR /app
COPY --from=builder /app/_build/prod/rel/reef/ .

CMD bin/mix phx.server
FROM elixir:alpine as builder

WORKDIR /app

COPY config/ /app/config/
COPY mix.exs /app/
COPY mix.* /app/

COPY apps/corals/mix.exs /app/apps/corals/
COPY apps/reef/mix.exs /app/apps/reef/

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get
RUN MIX_ENV=prod mix release corals


FROM elixir:alpine
WORKDIR /app
COPY --from=builder /app/_build/prod/rel/corals .

CMD bin/mix phx.server
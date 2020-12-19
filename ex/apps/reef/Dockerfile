FROM elixir:latest as builder
COPY . /app
WORKDIR /app
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get
RUN MIX_ENV=prod mix release


FROM elixir:slim
WORKDIR /app
COPY --from=builder /app/_build/prod/rel/reef/ .

CMD bin/mix phx.server
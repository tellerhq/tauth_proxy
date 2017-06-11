defmodule TAuthProxy.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    port = System.get_env("PORT") |> String.to_integer

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: TAuthProxy.Worker.start_link(arg1, arg2, arg3)
      # worker(TAuthProxy.Worker, [arg1, arg2, arg3]),
      Plug.Adapters.Cowboy.child_spec(:http, TAuthProxy.ProxyServer, [], [port: port])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TAuthProxy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

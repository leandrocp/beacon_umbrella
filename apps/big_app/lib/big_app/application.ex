defmodule BigApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BigApp.Repo,
      {DNSCluster, query: Application.get_env(:big_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BigApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: BigApp.Finch}
      # Start a worker by calling: BigApp.Worker.start_link(arg)
      # {BigApp.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: BigApp.Supervisor)
  end
end
